import Prelude hiding (signum)

{-
signum :: Integral a => a -> Int
signum x =
  if x < 0
    then -1
    else if x > 0
      then 1
      else 0
-}

signum :: Integral a => a -> Int
signum 0 = 0
signum n
  | n < 0     = -1
  | otherwise = 1
