module Img (
    extractRGBlist
) where
import Codec.Picture
import Data.Vector.Storable
import Lib

pixelToRGB :: PixelRGB8 -> RGB
pixelToRGB (PixelRGB8 r g b) = RGB (f r) (f g) (f b)
                               where f x = toDouble x / 255.0
                                     toDouble :: Pixel8 -> Double
                                     toDouble x = fromIntegral $ toInteger x

extractPixelVector :: Image PixelRGB8 -> Vector Pixel8
extractPixelVector (Image _ _ d) = d

extractPixels :: Vector Pixel8 -> [PixelRGB8]
extractPixels pixelVector  = let (pixelTriple, rest) = Data.Vector.Storable.splitAt 3 pixelVector 
                                 [r, g, b] = Data.Vector.Storable.toList pixelTriple
                                 cur_pixel = PixelRGB8 r g b in
                             if Data.Vector.Storable.length rest < 3
                             then [cur_pixel]
                             else cur_pixel:extractPixels rest

extractRGBlist :: Image PixelRGB8 ->  [RGB]
extractRGBlist img = Prelude.map pixelToRGB $ extractPixels $ extractPixelVector img
