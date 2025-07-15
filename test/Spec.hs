module Main where 
import Lib
import Test.Hspec
import Test.QuickCheck
import Test.Hspec.QuickCheck

instance Arbitrary RGB where
 arbitrary = RGB <$> choose (0.0,1.0) <*> choose (0.0,1.0) <*> choose (0.0,1.0)

main :: IO ()
main = hspec $ do
    describe "Testing" $ do
        it "rgbMean should compute the mean" $ do
            rgbMean [RGB 0 0 0, RGB 0.5 0.5 0.5, RGB 1.0 1.0 1.0] `shouldBe` RGB 0.5 0.5 0.5
        prop "mean of repeated list of rgb should be itself" $
            \rgb -> rgbMean [rgb, rgb, rgb] `shouldBe` rgb
        prop "kmeans always produces k means" $ do
            xs <- listOf1 arbitrary
            k <- chooseInt (1, max (length xs - 1) 1)
            return $ k === length (getCentroids (kMeans k xs))
