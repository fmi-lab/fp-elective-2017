{-
fibonacci :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 2) + fibonacci (n - 1)
-}

fibonacci :: Integral a => a -> a
fibonacci n = iter 0 1 n
  where
    iter current _ 0    = current
    iter current next n = iter next (current + next) (n - 1)
