countDigits :: Integral a => a -> a
countDigits n
  | n < 10    = 1
  | otherwise = 1 + countDigits (stripDigit n)
  where stripDigit = (`div` 10)
