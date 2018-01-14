{-
factorial :: Integral a => a -> a
factorial n =
  if n == 0
  then 1
  else n * factorial (n - 1)
-}

{-
factorial :: Integral a => a -> a
factorial n
  | n == 0    = 1
  | otherwise = n * factorial (n - 1)
-}

factorial :: Integral a => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)
