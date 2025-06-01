module Lib
(
 kMeans,
 sampleRGB,
 sampleMonochromatic,
 samplenRGB
 ) where

-- import required modules
import System.Random.Stateful
import Control.Monad (replicateM)
import Control.Foldl as Foldl 

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
 

-- Euclidean distance
euclideanDistance :: RGB -> RGB -> Double
euclideanDistance x1 x2 = let (RGB r g b) = (x1 - x2)^2 in
                          sqrt (r+g+b)

-- mean, used to compute centroids in kmeans algorithm
rgbMean :: [RGB] -> RGB
rgbMean = Foldl.fold Foldl.mean 

-- assign x to nearest kmean
assignCluster :: [RGB] -> RGB -> Maybe Int
assignCluster kmeans x = let distances = Prelude.map (euclideanDistance x) kmeans 
                             -- assign to closest centroid
                             m = Prelude.minimum distances in
                         -- get index of centroid
                         getIndex m distances 0
                         where getIndex :: Eq a => a -> [a] -> Int -> Maybe Int
                               getIndex _ [] _ = Nothing
                               getIndex m (d:ds) i = if m == d
                                                     then Just i
                                                     else getIndex m ds (i+1)

-- compute an iteration of the naive kmeans algorithm
kMeansIter :: [RGB] -> [RGB] -> [(RGB, [RGB])]
kMeansIter ks xs = let out = Prelude.map (assigner ks) xs in
                   -- return a list of each centroid and the colors assigned to that centroid
                   Prelude.map (listConstructor out ks) (unique $ Prelude.map snd out)
                   where assigner :: [RGB] -> RGB -> (RGB, Int)
                         assigner kmeans x = case assignCluster kmeans x of
                                             Just y -> (x, y)
                                             Nothing -> (x, -1)
                         listConstructor out kmeans i = (kmeans!!i, Prelude.map fst $ filter ((== i) . snd) out)
                         unique [] = []
                         unique (y:ys) = y:unique (filter (y /=) ys)

-- iterate until assignment does not change
kMeans :: [RGB] -> [RGB] -> [(RGB, [RGB])]
kMeans ks xs = let kmean_iter = kMeansIter ks xs
                   newks = Prelude.map (rgbMean . snd) kmean_iter in
               if ks == newks
               then kmean_iter
               else kMeans newks xs

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

-- randomly sample n colors using a given RGB sampler
samplenRGB :: StatefulGen a m => Int -> (a -> m RGB) -> a -> m [RGB]
samplenRGB n sampler = replicateM n . sampler 
