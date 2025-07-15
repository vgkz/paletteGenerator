module Lib
(
 RGB (RGB),
 rgbMean,
 kMeans,
 getCentroids,
 sampleRGB,
 sampleMonochromatic,
 samplenRGB,
 sortRGB,
 sortMonochrome
 ) where

-- import required modules
import System.Random.Stateful
import Control.Monad (replicateM)
import Control.Foldl as Foldl 
import Data.KMeans (kmeansGen)

-- a component of RGB colors is a Double 0-1
type Component = Double

-- defining RGB color type
data RGB = RGB Component Component Component
 deriving (Eq, Ord)

-- Implementing show instance to print RGB on more common 0-255 scale
instance Show RGB where
 show (RGB r g b) = let display = show . round . (*255) 
                        colorcode = "\ESC[38;2;" ++ display r ++ ";" ++ display g ++ ";" ++ display b ++ "m" in -- format "\Esc[38;2;r;g;bm"
                    colorcode ++ "RGB " ++ "\ESC[0m" ++ display r ++ " " ++ display g ++ " " ++ display b 

-- implement toDouble function used to define instance of Num
integerToDouble :: Integer -> Double
integerToDouble = fromInteger


-- Implementing RGB as an instance of Num
instance Num RGB where
 (+) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1+r2) (g1+g2) (b1+b2)
 (-) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1-r2) (g1-g2) (b1-b2)
 (*) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1*r2) (g1*g2) (b1*b2)
 abs (RGB r1 g1 b1) = RGB (abs r1) (abs g1) (abs b1)
 fromInteger i = RGB x x x where x = integerToDouble i 

-- Implementing RGB as an instance of Fractional 
instance Fractional RGB where
 (/) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1/r2) (g1/g2) (b1/b2)
 fromRational r = RGB f f f where f = fromRational r

-- defining monoid for RGB
instance Semigroup RGB where
 (<>) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1+r2) (g1+g2) (b1+b2)
instance Monoid RGB where
 mempty = RGB 0 0 0

-- defining uniform random sampling of rgb colors
instance UniformRange RGB where
 uniformRM (RGB r1 g1 b1, RGB r2 g2 b2) g = RGB <$> uniformRM (r1,r2) g <*> uniformRM (g1,g2) g <*> uniformRM (b1,b2) g

-- defining random sampling over a range
instance Uniform RGB where
 uniformM g = RGB <$> uniformRM (0,1) g <*> uniformRM (0,1) g <*> uniformRM (0,1) g
 
-- mean, used to compute centroids in kmeans algorithm
rgbMean :: [RGB] -> RGB
rgbMean = Foldl.fold Foldl.mean 

kMeans :: Int -> [RGB] -> [[RGB]]
kMeans k points = let centroids = kmeansGen f k points in
                  -- kmeans algorithm may not generate k clusters. To guarantee k centroids, repeat algorithm on one less 
                  -- point until k centroids is returned. Worst case it will iterate until the color space has k points. 
                  if Prelude.length centroids == k then centroids else kMeans k (tail points)
                  where f (RGB r g b) = [r, g, b]

getCentroids :: [[RGB]] -> [RGB]
getCentroids = Prelude.map rgbMean

-- generate a random RGB color
sampleRGB :: (StatefulGen g m) => g -> m RGB
sampleRGB = uniformM 

-- monochromatic random sampling of prespecified hues
sampleMonochromatic :: (StatefulGen g m) => String -> g -> m RGB
sampleMonochromatic hue g = do
                                 val1 <- uniformRM (0.1, 1) g
                                 val2 <- uniformRM (0, val1) g
                                 return $ case hue of
                                          "Red" -> RGB val1 val2 val2
                                          "Green" -> RGB val2 val1 val2
                                          "Blue" -> RGB val2 val2 val1
                                          "Yellow" -> RGB val1 val1 val2
                                          "Magenta" -> RGB val1 val2 val1
                                          "Cyan" -> RGB val2 val1 val1
                                          "Grey" -> RGB val1 val1 val1

---- Color sorting ----
-- map rgb to hsv for better sorting
rgbToHueChroma :: RGB -> (Double, Double)
rgbToHueChroma (RGB r b g) = let alpha = 0.5*(2.0*r-g-b)
                                 beta = (sqrt 3.0 / 2) * (g-b) in
                             (toHue alpha beta, toChroma alpha beta)
                             where toHue = atan2
                                   toChroma x y = sqrt $ x**2 + y**2

-- using Y'_601 
rgbToLuminosity :: RGB -> Double
rgbToLuminosity (RGB r g b) = 0.299*r+0.587*g+0.114*b

-- sort colors by hue, then chroma, then luminence
sortRGB :: RGB -> RGB -> Ordering
sortRGB rgb1 rgb2 | h1<h2 = LT
                  | h1>h2 = GT
                  | c1<c2 = LT
                  | c1>c2 = LT
                  | s1<=s2 = LT
                  | otherwise = GT
                    where (h1, c1) = rgbToHueChroma rgb1
                          (h2, c2) = rgbToHueChroma rgb2
                          s1 = rgbToLuminosity rgb1
                          s2 = rgbToLuminosity rgb2

-- sort monochrome colors by luminosity (yields more reasonable results)
sortMonochrome :: RGB -> RGB -> Ordering
sortMonochrome rgb1 rgb2 | s1 <= s2 = LT
                         | otherwise = GT
                         where s1 = rgbToLuminosity rgb1
                               s2 = rgbToLuminosity rgb2


-- randomly sample n colors using a given RGB sampler
samplenRGB :: StatefulGen a m => Int -> (a -> m RGB) -> a -> m [RGB]
samplenRGB n sampler = replicateM n . sampler 
