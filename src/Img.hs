module Img (
    extractRGBlist,
    readImg
) where
import Codec.Picture
import Data.Vector.Storable
import Lib

pixelToRGB :: PixelRGB16 -> RGB
pixelToRGB (PixelRGB16 r g b) = RGB (f r) (f g) (f b)
                               where f x = toDouble x / 255.0
                                     toDouble :: Pixel16 -> Double
                                     toDouble x = fromIntegral $ toInteger x

extractPixelVector :: Image PixelRGB16 -> Vector Pixel16
extractPixelVector (Image _ _ d) = d

extractPixels :: Vector Pixel16 -> [PixelRGB16]
extractPixels pixelVector  = let (pixelTriple, rest) = Data.Vector.Storable.splitAt 3 pixelVector 
                                 [r, g, b] = Data.Vector.Storable.toList pixelTriple
                                 cur_pixel = PixelRGB16 r g b in
                             if Data.Vector.Storable.length rest < 3
                             then [cur_pixel]
                             else cur_pixel:extractPixels rest

extractRGBlist :: Image PixelRGB16 ->  [RGB]
extractRGBlist img = Prelude.map pixelToRGB $ extractPixels $ extractPixelVector img



readImg :: FilePath -> IO (Either String (Image PixelRGB16))
readImg fp = do 
    iores <- Codec.Picture.readImage fp
    case iores of
        Left msg -> return $ Left msg
        Right img -> return $ Right $ convertRGB16 img
