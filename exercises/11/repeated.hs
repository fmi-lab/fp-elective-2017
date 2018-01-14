repeated :: (a -> a) -> Int -> a -> a
repeated _ 0 x = x
repeated f n x = f (repeated f (n - 1) x)
