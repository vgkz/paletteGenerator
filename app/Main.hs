module Main (main) where

import Options.Applicative
import System.Random.Stateful
import Data.List
import Data.Maybe
import Lib
import Img

-- type for command line arguments
data Options = Options {
    ncolors :: Int,
    monochromatic :: Bool,
    monoHue :: String,
    seed :: Maybe Int,
    fromImage :: Bool,
    filePath :: Maybe String
    }

-- Reads monoHue option and throws error if unimplemented hue is provided
monoHueReader :: ReadM String
monoHueReader = eitherReader $ \arg -> do
                                        if arg `elem` validHues 
                                        then return arg
                                        else Left $ "Invalid monochromatic hue, valid hues are: " ++ show validHues
                where validHues = ["Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Grey"]

-- Parser for command line options
options :: Parser Options
options = Options
    <$> option auto
        (long "ncolors"
        <> help "Number of colors to include in generated palette")
    <*> switch
        (long "monochromatic"
        <> help "Should a monochromatic palette be generated?")
    <*> option monoHueReader 
        (long "monoHue"
        <> help "Which monochromatic palette should be generated? (defaults to Grey)"
        <> value "Grey")
    <*> optional (option auto
        (long "seed"
        <> help "Set a seed for random palette generation"))
    <*> switch
        (long "fromImage"
        <> help "Should palette be generated from an image?")
    <*> optional (strOption
        (long "filePath"
        <> help "filepath to read image from"))


-- Generate palette from centroids in selected color space
colorSpaceToCentroids :: Bool -> Int -> [RGB] -> IO ()
colorSpaceToCentroids b n colorSpace = do
    let initKmeans = take n colorSpace 
    let out = kMeans initKmeans colorSpace
    let newPalette = Prelude.map fst out
    let sortedPalette = if b then sortBy sortMonochrome newPalette else sortBy sortRGB newPalette
    putStrLn "Generated palette: "
    print sortedPalette


-- Main programme functionality, takes command line options as input
optsToIO :: Options -> IO ()
optsToIO (Options n b s usrSeed fi fp) = let sampler = if b then sampleMonochromatic s else sampleRGB in
    do
        -- generate without seed if no seed is provided
        randomGenerator <- case usrSeed of
            Just x -> return $ mkStdGen x
            Nothing -> getStdGen
        -- if fromImage, generate colorSpace from image filepath 
        if fi
        then case fp of
             Just filepath -> do 
                                print filepath
                                readResult <- readImg filepath
                                tryImgPalette readResult
                                where tryImgPalette (Left msg) = print msg
                                      tryImgPalette (Right img) = colorSpaceToCentroids b n (extractRGBlist img)
             Nothing -> print "Invalid filepath"
        -- else generate random palette on randomly generated colors
        else let randomColors = runStateGen_ randomGenerator (samplenRGB n sampler) in 
             colorSpaceToCentroids b n randomColors 
                                    

-- parse options and pass to optsToIO
main :: IO ()
main = optsToIO =<< execParser opts
    where opts = info (options <**> helper)
            (fullDesc
            <> progDesc "generate a color palette"
            <> header "A simple palette generator")
