module Main (main) where

import Options.Applicative
import System.Random.Stateful
import Lib

-- type for command line arguments
data Options = Options {
    ncolors :: Int,
    monochromatic :: Bool,
    monoHue :: String,
    seed :: Maybe Int
    }

-- Reads monoHue option and throws error if unimplemented hue is provided
monoHueReader :: ReadM String
monoHueReader = eitherReader $ \arg -> do
                                        if elem arg validHues 
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

-- Main programme functionality, takes command line options as input
optsToIO :: Options -> IO ()
optsToIO (Options n b s usrSeed) = let sampler = if b then sampleMonochromatic s else sampleRGB in
                                do
                                 -- generate without seed if no seed is provided
                                 randomGenerator <- case usrSeed of
                                                     Just x -> return $ mkStdGen x
                                                     Nothing -> getStdGen
                                 -- generate random palette by kmeans clustering on randomly generated colors
                                 let randomColors = runStateGen_ randomGenerator (samplenRGB 1000 sampler)
                                 let initKmeans = runStateGen_ randomGenerator (samplenRGB n sampler)
                                 let out = kMeans initKmeans randomColors
                                 let newMeans = Prelude.map fst out
                                 -- print generated palette as output
                                 putStrLn "Generated palette: "
                                 print newMeans

-- parse options and pass to optsToIO
main :: IO ()
main = optsToIO =<< execParser opts
    where opts = info (options <**> helper)
            (fullDesc
            <> progDesc "generate a color palette"
            <> header "A simple palette generator")
