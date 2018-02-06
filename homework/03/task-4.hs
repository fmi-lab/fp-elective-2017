reprs :: [Int]
reprs =
  [length [() | p <- [2..n `quot` 2], prime p, prime (n - p)] | n <- [0..]]
    where prime n = null [d | d <- [2..isqrt n], n `mod` d == 0]
          isqrt = floor . sqrt . fromIntegral
