fastPow :: Fractional a => a -> Int -> a
fastPow _ 0 = 1
fastPow x n
  | n < 0     = 1 / x `fastPow` (-n)
  | even n    = x `fastPow` (n `div` 2) ^ 2
  | otherwise = x * x `fastPow` (n - 1)
