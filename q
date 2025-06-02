[33mcommit 9e2405989961c4de1a0e93505caeb0ff75b32c30[m[33m ([m[1;36mHEAD -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m)[m
Author: faer <ferikson77@gmail.com>
Date:   Tue May 27 22:13:57 2025 +0200

    initial commit

[1mdiff --git a/.gitignore b/.gitignore[m
[1mnew file mode 100644[m
[1mindex 0000000..c368d45[m
[1m--- /dev/null[m
[1m+++ b/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m.stack-work/[m
[32m+[m[32m*~[m
\ No newline at end of file[m
[1mdiff --git a/README.md b/README.md[m
[1mnew file mode 100644[m
[1mindex 0000000..072952e[m
[1m--- /dev/null[m
[1m+++ b/README.md[m
[36m@@ -0,0 +1 @@[m
[32m+[m[32m# paletteGenerator[m
[1mdiff --git a/Setup.hs b/Setup.hs[m
[1mnew file mode 100644[m
[1mindex 0000000..9a994af[m
[1m--- /dev/null[m
[1m+++ b/Setup.hs[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32mimport Distribution.Simple[m
[32m+[m[32mmain = defaultMain[m
[1mdiff --git a/app/Main.hs b/app/Main.hs[m
[1mnew file mode 100644[m
[1mindex 0000000..6bd2b4f[m
[1m--- /dev/null[m
[1m+++ b/app/Main.hs[m
[36m@@ -0,0 +1,6 @@[m
[32m+[m[32mmodule Main (main) where[m
[32m+[m
[32m+[m[32mimport Lib[m
[32m+[m
[32m+[m[32mmain :: IO ()[m
[32m+[m[32mmain = mainfunc[m
[1mdiff --git a/package.yaml b/package.yaml[m
[1mnew file mode 100644[m
[1mindex 0000000..7a2fe35[m
[1m--- /dev/null[m
[1m+++ b/package.yaml[m
[36m@@ -0,0 +1,61 @@[m
[32m+[m[32mname:                paletteGenerator[m
[32m+[m[32mversion:             0.1.0.0[m
[32m+[m[32mgithub:              "vgkz/paletteGenerator"[m
[32m+[m[32mlicense:             BSD-3-Clause[m
[32m+[m[32mauthor:              "faer"[m
[32m+[m[32mmaintainer:          "example@example.com"[m
[32m+[m[32mcopyright:           "2025 faer"[m
[32m+[m
[32m+[m[32mextra-source-files:[m
[32m+[m[32m- README.md[m
[32m+[m[32m- CHANGELOG.md[m
[32m+[m
[32m+[m[32m# Metadata used when publishing your package[m
[32m+[m[32m# synopsis:            Short description of your package[m
[32m+[m[32m# category:            Web[m
[32m+[m
[32m+[m[32m# To avoid duplicated efforts in documentation and dealing with the[m
[32m+[m[32m# complications of embedding Haddock markup inside cabal files, it is[m
[32m+[m[32m# common to point users to the README.md file.[m
[32m+[m[32mdescription:         Please see the README on GitHub at <https://github.com/vgkz/paletteGenerator#readme>[m
[32m+[m
[32m+[m[32mdependencies:[m
[32m+[m[32m- base >= 4.7 && < 5[m
[32m+[m[32m- random[m
[32m+[m[32m- foldl[m
[32m+[m
[32m+[m[32mghc-options:[m
[32m+[m[32m- -Wall[m
[32m+[m[32m- -Wcompat[m
[32m+[m[32m- -Widentities[m
[32m+[m[32m- -Wincomplete-record-updates[m
[32m+[m[32m- -Wincomplete-uni-patterns[m
[32m+[m[32m- -Wmissing-export-lists[m
[32m+[m[32m- -Wmissing-home-modules[m
[32m+[m[32m- -Wpartial-fields[m
[32m+[m[32m- -Wredundant-constraints[m
[32m+[m
[32m+[m[32mlibrary:[m
[32m+[m[32m  source-dirs: src[m
[32m+[m
[32m+[m[32mexecutables:[m
[32m+[m[32m  paletteGenerator-exe:[m
[32m+[m[32m    main:                Main.hs[m
[32m+[m[32m    source-dirs:         app[m
[32m+[m[32m    ghc-options:[m
[32m+[m[32m    - -threaded[m
[32m+[m[32m    - -rtsopts[m
[32m+[m[32m    - -with-rtsopts=-N[m
[32m+[m[32m    dependencies:[m
[32m+[m[32m    - paletteGenerator[m
[32m+[m
[32m+[m[32mtests:[m
[32m+[m[32m  paletteGenerator-test:[m
[32m+[m[32m    main:                Spec.hs[m
[32m+[m[32m    source-dirs:         test[m
[32m+[m[32m    ghc-options:[m
[32m+[m[32m    - -threaded[m
[32m+[m[32m    - -rtsopts[m
[32m+[m[32m    - -with-rtsopts=-N[m
[32m+[m[32m    dependencies:[m
[32m+[m[32m    - paletteGenerator[m
[1mdiff --git a/paletteGenerator.cabal b/paletteGenerator.cabal[m
[1mnew file mode 100644[m
[1mindex 0000000..919ab57[m
[1m--- /dev/null[m
[1m+++ b/paletteGenerator.cabal[m
[36m@@ -0,0 +1,73 @@[m
[32m+[m[32mcabal-version: 2.2[m
[32m+[m
[32m+[m[32m-- This file has been generated from package.yaml by hpack version 0.37.0.[m
[32m+[m[32m--[m
[32m+[m[32m-- see: https://github.com/sol/hpack[m
[32m+[m
[32m+[m[32mname:           paletteGenerator[m
[32m+[m[32mversion:        0.1.0.0[m
[32m+[m[32mdescription:    Please see the README on GitHub at <https://github.com/vgkz/paletteGenerator#readme>[m
[32m+[m[32mhomepage:       https://github.com/vgkz/paletteGenerator#readme[m
[32m+[m[32mbug-reports:    https://github.com/vgkz/paletteGenerator/issues[m
[32m+[m[32mauthor:         faer[m
[32m+[m[32mmaintainer:     example@example.com[m
[32m+[m[32mcopyright:      2025 faer[m
[32m+[m[32mlicense:        BSD-3-Clause[m
[32m+[m[32mlicense-file:   LICENSE[m
[32m+[m[32mbuild-type:     Simple[m
[32m+[m[32mextra-source-files:[m
[32m+[m[32m    README.md[m
[32m+[m[32m    CHANGELOG.md[m
[32m+[m
[32m+[m[32msource-repository head[m
[32m+[m[32m  type: git[m
[32m+[m[32m  location: https://github.com/vgkz/paletteGenerator[m
[32m+[m
[32m+[m[32mlibrary[m
[32m+[m[32m  exposed-modules:[m
[32m+[m[32m      Lib[m
[32m+[m[32m  other-modules:[m
[32m+[m[32m      Paths_paletteGenerator[m
[32m+[m[32m  autogen-modules:[m
[32m+[m[32m      Paths_paletteGenerator[m
[32m+[m[32m  hs-source-dirs:[m
[32m+[m[32m      src[m
[32m+[m[32m  ghc-options: -Wall -Wcompat -Widentities -Wincomplete-record-updates -Wincomplete-uni-patterns -Wmissing-export-lists -Wmissing-home-modules -Wpartial-fields -Wredundant-constraints[m
[32m+[m[32m  build-depends:[m
[32m+[m[32m      base >=4.7 && <5[m
[32m+[m[32m    , foldl[m
[32m+[m[32m    , random[m
[32m+[m[32m  default-language: Haskell2010[m
[32m+[m
[32m+[m[32mexecutable paletteGenerator-exe[m
[32m+[m[32m  main-is: Main.hs[m
[32m+[m[32m  other-modules:[m
[32m+[m[32m      Paths_paletteGenerator[m
[32m+[m[32m  autogen-modules:[m
[32m+[m[32m      Paths_paletteGenerator[m
[32m+[m[32m  hs-source-dirs:[m
[32m+[m[32m      app[m
[32m+[m[32m  ghc-options: -Wall -Wcompat -Widentities -Wincomplete-record-updates -Wincomplete-uni-patterns -Wmissing-export-lists -Wmissing-home-modules -Wpartial-fields -Wredundant-constraints -threaded -rtsopts -with-rtsopts=-N[m
[32m+[m[32m  build-depends:[m
[32m+[m[32m      base >=4.7 && <5[m
[32m+[m[32m    , foldl[m
[32m+[m[32m    , paletteGenerator[m
[32m+[m[32m    , random[m
[32m+[m[32m  default-language: Haskell2010[m
[32m+[m
[32m+[m[32mtest-suite paletteGenerator-test[m
[32m+[m[32m  type: exitcode-stdio-1.0[m
[32m+[m[32m  main-is: Spec.hs[m
[32m+[m[32m  other-modules:[m
[32m+[m[32m      Paths_paletteGenerator[m
[32m+[m[32m  autogen-modules:[m
[32m+[m[32m      Paths_paletteGenerator[m
[32m+[m[32m  hs-source-dirs:[m
[32m+[m[32m      test[m
[32m+[m[32m  ghc-options: -Wall -Wcompat -Widentities -Wincomplete-record-updates -Wincomplete-uni-patterns -Wmissing-export-lists -Wmissing-home-modules -Wpartial-fields -Wredundant-constraints -threaded -rtsopts -with-rtsopts=-N[m
[32m+[m[32m  build-depends:[m
[32m+[m[32m      base >=4.7 && <5[m
[32m+[m[32m    , foldl[m
[32m+[m[32m    , paletteGenerator[m
[32m+[m[32m    , random[m
[32m+[m[32m  default-language: Haskell2010[m
[1mdiff --git a/src/Lib.hs b/src/Lib.hs[m
[1mnew file mode 100644[m
[1mindex 0000000..eea3eef[m
[1m--- /dev/null[m
[1m+++ b/src/Lib.hs[m
[36m@@ -0,0 +1,105 @@[m
[32m+[m[32mmodule Lib([m
[32m+[m[32m mainfunc[m
[32m+[m[32m ) where[m
[32m+[m[32mimport System.Random.Stateful[m
[32m+[m[32mimport Control.Monad (replicateM)[m
[32m+[m[32mimport Control.Foldl as Foldl[m[41m [m
[32m+[m
[32m+[m[32m-- a component of RGB colors is an Int[m
[32m+[m[32mtype Component = Double[m
[32m+[m
[32m+[m[32mdata RGB = RGB Component Component Component[m
[32m+[m[32m deriving (Eq, Ord)[m
[32m+[m
[32m+[m[32minstance Show RGB where[m
[32m+[m[32m show (RGB r g b) = let display = show . round . (*255) in[m
[32m+[m[32m                   "RGB " ++ display r ++ " " ++ display g ++ " " ++ display b[m[41m [m
[32m+[m
[32m+[m[32mintegerToDouble :: Integer -> Double[m
[32m+[m[32mintegerToDouble = fromInteger[m
[32m+[m
[32m+[m[32minstance Num RGB where[m
[32m+[m[32m (+) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1+r2) (g1+g2) (b1+b2)[m
[32m+[m[32m (-) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1-r2) (g1-g2) (b1-b2)[m
[32m+[m[32m (*) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1*r2) (g1*g2) (b1*b2)[m
[32m+[m[32m abs (RGB r1 g1 b1) = RGB (abs r1) (abs g1) (abs b1)[m
[32m+[m[32m fromInteger i = RGB x x x where x = integerToDouble i[m[41m [m
[32m+[m
[32m+[m[32minstance Fractional RGB where[m
[32m+[m[32m (/) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1/r2) (g1/g2) (b1/b2)[m
[32m+[m[32m fromRational r = RGB f f f where f = fromRational r[m
[32m+[m
[32m+[m[32m-- defining monoid for RGB[m
[32m+[m[32minstance Semigroup RGB where[m
[32m+[m[32m (<>) (RGB r1 g1 b1) (RGB r2 g2 b2) = RGB (r1+r2) (g1+g2) (b1+b2)[m
[32m+[m[32minstance Monoid RGB where[m
[32m+[m[32m mempty = RGB 0 0 0[m
[32m+[m
[32m+[m[32minstance Uniform RGB where[m
[32m+[m[32m uniformM g = RGB <$> uniformRM (0,1) g <*> uniformRM (0,1) g <*> uniformRM (0,1) g[m
[32m+[m
[32m+[m[32m-- Definition of the three primary colors[m
[32m+[m[32mred :: RGB[m
[32m+[m[32mred   = RGB 1 0 0[m
[32m+[m[32mgreen :: RGB[m
[32m+[m[32mgreen = RGB 0 1 0[m
[32m+[m[32mblue :: RGB[m
[32m+[m[32mblue  = RGB 0 0 1[m
[32m+[m
[32m+[m[32m-- Euclidean distance[m
[32m+[m[32meuclideanDistance :: RGB -> RGB -> Double[m
[32m+[m[32meuclideanDistance x1 x2 = let (RGB r g b) = (x1 - x2)^2 in[m
[32m+[m[32m                          sqrt (r+g+b)[m
[32m+[m
[32m+[m[32m-- mean[m
[32m+[m[32mrgbMean :: [RGB] -> RGB[m
[32m+[m[32mrgbMean = Foldl.fold Foldl.mean[m[41m [m
[32m+[m
[32m+[m[32m-- assign x to nearest kmean[m
[32m+[m[32massignCluster :: [RGB] -> RGB -> Maybe Int[m
[32m+[m[32massignCluster kmeans x = let distances = Prelude.map (euclideanDistance x) kmeans[m[41m [m
[32m+[m[32m                             m = Prelude.minimum distances in[m
[32m+[m[32m                         getIndex m distances 0[m
[32m+[m[32m                         where getIndex :: Eq a => a -> [a] -> Int -> Maybe Int[m
[32m+[m[32m                               getIndex _ [] _ = Nothing[m
[32m+[m[32m                               getIndex m (d:ds) i = if m == d[m
[32m+[m[32m                                                     then Just i[m
[32m+[m[32m                                                     else getIndex m ds (i+1)[m
[32m+[m
[32m+[m[32m-- compute an iteration of the naive kmeans algorithm[m
[32m+[m[32mkMeansIter :: [RGB] -> [RGB] -> [(RGB, [RGB])][m
[32m+[m[32mkMeansIter ks xs = let out = Prelude.map (assigner ks) xs in[m
[32m+[m[32m                   Prelude.map (listConstructor out ks) (unique $ Prelude.map snd out)[m
[32m+[m[32m                   where assigner :: [RGB] -> RGB -> (RGB, Int)[m
[32m+[m[32m                         assigner kmeans x = case assignCluster kmeans x of[m
[32m+[m[32m                                             Just y -> (x, y)[m
[32m+[m[32m                                             Nothing -> (x, -1)[m
[32m+[m[32m                         listConstructor out kmeans i = (kmeans!!i, Prelude.map fst $ filter ((== i) . snd) out)[m
[32m+[m[32m                         unique [] = [][m
[32m+[m[32m                         unique (y:ys) = y:unique (filter (y /=) ys)[m
[32m+[m
[32m+[m[32m-- iterate until assignment does not change[m
[32m+[m[32mkMeans :: [RGB] -> [RGB] -> [(RGB, [RGB])][m
[32m+[m[32mkMeans ks xs = let kmean_iter = kMeansIter ks xs[m
[32m+[m[32m                   newks = Prelude.map (rgbMean . snd) kmean_iter in[m
[32m+[m[32m               if ks == newks[m
[32m+[m[32m               then kmean_iter[m
[32m+[m[32m               else kMeans newks xs[m
[32m+[m
[32m+[m[32m-- generate a random RGB color[m
[32m+[m[32msampleRGB :: (StatefulGen g m) => g -> m RGB[m
[32m+[m[32msampleRGB = uniformM[m[41m [m
[32m+[m
[32m+[m[32m-- generate n random RGB colors[m
[32m+[m[32msamplenRGB :: StatefulGen a m => Int -> a -> m [RGB][m
[32m+[m[32msamplenRGB n = replicateM n . sampleRGB[m[41m [m
[32m+[m
[32m+[m[32mmainfunc :: IO ()[m
[32m+[m[32mmainfunc = do[m
[32m+[m[32m            putStrLn "Provide an integer seed"[m
[32m+[m[32m            inp <- getLine[m
[32m+[m[32m            let seed = read inp[m
[32m+[m[32m            let randomColors = runStateGen_ (mkStdGen seed) (samplenRGB 1000)[m
[32m+[m[32m            let out = kMeans [red, green, blue] randomColors[m
[32m+[m[32m            let newMeans = Prelude.map fst out[m
[32m+[m[32m            print newMeans[m
[1mdiff --git a/stack.yaml b/stack.yaml[m
[1mnew file mode 100644[m
[1mindex 0000000..2525123[m
[1m--- /dev/null[m
[1m+++ b/stack.yaml[m
[36m@@ -0,0 +1,67 @@[m
[32m+[m[32m# This file was automatically generated by 'stack init'[m
[32m+[m[32m#[m
[32m+[m[32m# Some commonly used options have been documented as comments in this file.[m
[32m+[m[32m# For advanced use and comprehensive documentation of the format, please see:[m
[32m+[m[32m# https://docs.haskellstack.org/en/stable/configure/yaml/[m
[32m+[m
[32m+[m[32m# A 'specific' Stackage snapshot or a compiler version.[m
[32m+[m[32m# A snapshot resolver dictates the compiler version and the set of packages[m
[32m+[m[32m# to be used for project dependencies. For example:[m
[32m+[m[32m#[m
[32m+[m[32m# snapshot: lts-23.0[m
[32m+[m[32m# snapshot: nightly-2024-12-13[m
[32m+[m[32m# snapshot: ghc-9.8.4[m
[32m+[m[32m#[m
[32m+[m[32m# The location of a snapshot can be provided as a file or url. Stack assumes[m
[32m+[m[32m# a snapshot provided as a file might change, whereas a url resource does not.[m
[32m+[m[32m#[m
[32m+[m[32m# snapshot: ./custom-snapshot.yaml[m
[32m+[m[32m# snapshot: https://example.com/snapshots/2024-01-01.yaml[m
[32m+[m[32msnapshot:[m
[32m+[m[32m  url: https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/23/23.yaml[m
[32m+[m
[32m+[m[32m# User packages to be built.[m
[32m+[m[32m# Various formats can be used as shown in the example below.[m
[32m+[m[32m#[m
[32m+[m[32m# packages:[m
[32m+[m[32m# - some-directory[m
[32m+[m[32m# - https://example.com/foo/bar/baz-0.0.2.tar.gz[m
[32m+[m[32m#   subdirs:[m
[32m+[m[32m#   - auto-update[m
[32m+[m[32m#   - wai[m
[32m+[m[32mpackages:[m
[32m+[m[32m- .[m
[32m+[m[32m# Dependency packages to be pulled from upstream that are not in the snapshot.[m
[32m+[m[32m# These entries can reference officially published versions as well as[m
[32m+[m[32m# forks / in-progress versions pinned to a git hash. For example:[m
[32m+[m[32m#[m
[32m+[m[32m# extra-deps:[m
[32m+[m[32m# - acme-missiles-0.3[m
[32m+[m[32m# - git: https://github.com/commercialhaskell/stack.git[m
[32m+[m[32m#   commit: e7b331f14bcffb8367cd58fbfc8b40ec7642100a[m
[32m+[m[32m#[m
[32m+[m[32m# extra-deps: [][m
[32m+[m
[32m+[m[32m# Override default flag values for project packages and extra-deps[m
[32m+[m[32m# flags: {}[m
[32m+[m
[32m+[m[32m# Extra package databases containing global packages[m
[32m+[m[32m# extra-package-dbs: [][m
[32m+[m
[32m+[m[32m# Control whether we use the GHC we find on the path[m
[32m+[m[32m# system-ghc: true[m
[32m+[m[32m#[m
[32m+[m[32m# Require a specific version of Stack, using version ranges[m
[32m+[m[32m# require-stack-version: -any # Default[m
[32m+[m[32m# require-stack-version: ">=3.3"[m
[32m+[m[32m#[m
[32m+[m[32m# Override the architecture used by Stack, especially useful on Windows[m
[32m+[m[32m# arch: i386[m
[32m+[m[32m# arch: x86_64[m
[32m+[m[32m#[m
[32m+[m[32m# Extra directories used by Stack for building[m
[32m+[m[32m# extra-include-dirs: [/path/to/dir][m
[32m+[m[32m# extra-lib-dirs: [/path/to/dir][m
[32m+[m[32m#[m
[32m+[m[32m# Allow a newer minor version of GHC than the snapshot specifies[m
[32m+[m[32m# compiler-check: newer-minor[m
[1mdiff --git a/stack.yaml.lock b/stack.yaml.lock[m
[1mnew file mode 100644[m
[1mindex 0000000..9c05ef4[m
[1m--- /dev/null[m
[1m+++ b/stack.yaml.lock[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32m# This file was autogenerated by Stack.[m
[32m+[m[32m# You should not edit this file by hand.[m
[32m+[m[32m# For more information, please see the documentation at:[m
[32m+[m[32m#   https://docs.haskellstack.org/en/stable/topics/lock_files[m
[32m+[m
[32m+[m[32mpackages: [][m
[32m+[m[32msnapshots:[m
[32m+[m[32m- completed:[m
[32m+[m[32m    sha256: 5e44cb81460cd2f90011ab6868958d58bde10f63babf4847a56118450b51221e[m
[32m+[m[32m    size: 683836[m
[32m+[m[32m    url: https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/23/23.yaml[m
[32m+[m[32m  original:[m
[32m+[m[32m    url: https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/23/23.yaml[m
[1mdiff --git a/test/Spec.hs b/test/Spec.hs[m
[1mnew file mode 100644[m
[1mindex 0000000..cd4753f[m
[1m--- /dev/null[m
[1m+++ b/test/Spec.hs[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32mmain :: IO ()[m
[32m+[m[32mmain = putStrLn "Test suite not yet implemented"[m
