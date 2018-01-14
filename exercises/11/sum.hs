import Prelude hiding (sum)

sum :: Int -> Int -> Int
sum start end
  | start > end = 0
  | otherwise   = start + sum (start + 1) end
