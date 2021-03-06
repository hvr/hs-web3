-- |
-- Module      :  Network.Ethereum.Web3.EncodingUtils
-- Copyright   :  Alexander Krupenkin 2016
-- License     :  BSD3
--
-- Maintainer  :  mail@akru.me
-- Stability   :  experimental
-- Portability :  portable
--
-- ABI encoding functions.
--
module Network.Ethereum.Web3.EncodingUtils where

import Data.Text.Lazy.Builder (Builder, toLazyText, fromText, fromLazyText)
import qualified Data.ByteString.Base16        as BS16 (decode, encode)
import qualified Data.Attoparsec.Text          as P
import qualified Data.Text.Lazy                as LT
import qualified Data.Text                     as T
import qualified Data.Text.Read                as R
import Data.Text.Encoding (encodeUtf8, decodeUtf8)
import Data.Attoparsec.Text.Lazy (Parser)
import Data.Text.Lazy.Builder.Int as B
import Data.Monoid ((<>))
import Data.Text (Text)
import Data.Bits (Bits)

-- | Make 256bit aligment; lazy (left, right)
align :: Builder -> (Builder, Builder)
align v = (v <> zeros, zeros <> v)
  where zerosLen | LT.length s `mod` 64 == 0 = 0
                 | otherwise = 64 - (LT.length s `mod` 64)
        zeros = fromLazyText (LT.replicate zerosLen "0")
        s = toLazyText v

alignL, alignR :: Builder -> Builder
{-# INLINE alignL #-}
alignL = fst . align
{-# INLINE alignR #-}
alignR = snd . align

int256HexBuilder :: Integral a => a -> Builder
int256HexBuilder x | x < 0 = int256HexBuilder (2^256 + fromIntegral x)
                   | otherwise = alignR (B.hexadecimal x)

int256HexParser :: (Bits a, Integral a) => Parser a
int256HexParser = do
    hex <- P.take 64
    case R.hexadecimal hex of
        Right (v, "") -> return v
        _ -> fail ("Broken hexadecimal: `" ++ T.unpack hex ++ "`")

textBuilder :: Text -> Builder
textBuilder s = int256HexBuilder (T.length hex `div` 2)
             <> alignL (fromText hex)
  where textToHex = decodeUtf8 . BS16.encode . encodeUtf8
        hex = textToHex s

textParser :: Parser Text
textParser = do
    len <- int256HexParser
    let zeroBytes = 32 - (len `mod` 32)
    str <- P.take (len * 2) <* P.take (zeroBytes * 2)
    return (hexToText str)
  where hexToText = decodeUtf8 . fst . BS16.decode . encodeUtf8
