module Lib
(
 mainfunc
 ) where
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
 show (RGB r g b) = let display = show . round . (*255) in
                   "RGB " ++ display r ++ " " ++ display g ++ " " ++ display b 

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

instance Uniform RGB where
 uniformM g = RGB <$> uniformRM (0,1) g <*> uniformRM (0,1) g <*> uniformRM (0,1) g

-- Euclidean distance
euclideanDistance :: RGB -> RGB -> Double
euclideanDistance x1 x2 = let (RGB r g b) = (x1 - x2)^2 in
                          sqrt (r+g+b)

-- mean
rgbMean :: [RGB] -> RGB
rgbMean = Foldl.fold Foldl.mean 

-- assign x to nearest kmean
assignCluster :: [RGB] -> RGB -> Maybe Int
assignCluster kmeans x = let distances = Prelude.map (euclideanDistance x) kmeans 
                             m = Prelude.minimum distances in
                         getIndex m distances 0
                         where getIndex :: Eq a => a -> [a] -> Int -> Maybe Int
                               getIndex _ [] _ = Nothing
                               getIndex m (d:ds) i = if m == d
                                                     then Just i
                                                     else getIndex m ds (i+1)

-- compute an iteration of the naive kmeans algorithm
kMeansIter :: [RGB] -> [RGB] -> [(RGB, [RGB])]
kMeansIter ks xs = let out = Prelude.map (assigner ks) xs in
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

-- generate n random RGB colors
samplenRGB :: StatefulGen a m => Int -> a -> m [RGB]
samplenRGB n = replicateM n . sampleRGB 

mainfunc :: IO ()
mainfunc = do
            putStrLn "Provide an integer seed: "
            inp <- getLine
            let seed = read inp
            let randomGenerator = mkStdGen seed
            putStrLn "How many colors would you like?: "
            inp2 <- getLine
            let user_k = read inp2
            let randomColors = runStateGen_ randomGenerator (samplenRGB 1000)
            let initKmeans = runStateGen_ randomGenerator (samplenRGB user_k) 
            let out = kMeans initKmeans randomColors
            let newMeans = Prelude.map fst out
            putStrLn "generated palette: "
            print newMeans
