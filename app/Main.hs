module Main (main) where

import Options.Applicative
import System.Random.Stateful
import Lib

data Options = Options {
    ncolors :: Int,
    monochromatic :: Bool,
    monoHue :: String
    }

options :: Parser Options
options = Options
    <$> option auto
        (long "ncolors"
        <> help "Number of colors to include in generated palette")
    <*> switch
        (long "monochromatic"
        <> help "Should a monochromatic palette be generated?")
    <*> strOption
        (long "monoHue"
        <> help "Which monochromatic palette should be generated? (defaults to Red)"
        <> value "Red")

optsToIO :: Options -> IO ()
optsToIO (Options n b s) = do
                            let seed = 2
                            let randomGenerator = mkStdGen seed
                            let randomColors = runStateGen_ randomGenerator (samplenRGB 1000)
                            let initKmeans = runStateGen_ randomGenerator (samplenRGB n)
                            let out = kMeans initKmeans randomColors
                            let newMeans = Prelude.map fst out
                            putStrLn "Generated palette: "
                            print newMeans
                            print s
                            print b

main :: IO ()
main = optsToIO =<< execParser opts
    where opts = info (options <**> helper)
            (fullDesc
            <> progDesc "generate a color palette"
            <> header "A simple palette generator")
