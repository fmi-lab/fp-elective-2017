hasSaddle :: (Num a, Ord a) => [[a]] -> Bool
hasSaddle = not . null . allSaddles

allSaddles :: (Num a, Ord a) => [[a]] -> [(Int, Int)]
allSaddles m =
  [(i, j) | i <- [0..length m - 1],
            j <- [0..length (head m) - 1],
            isSaddle (i, j)]
    where columns = [map (!!i) m | i <- [0..length (head m) - 1]]
          rowMinsAndMaxes = minsAndMaxes m
          colMinsAndMaxes = minsAndMaxes columns
          minsAndMaxes = map (\ xs -> (minimum xs, maximum xs))
          isSaddle (i, j) =
            (fst $ rowMinsAndMaxes !! i) == (snd $ colMinsAndMaxes !! j) ||
            (snd $ rowMinsAndMaxes !! i) == (fst $ colMinsAndMaxes !! j)
