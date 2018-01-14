{-
accumulate :: (a -> b -> b) -> b -> (Int -> a) ->
              Int -> (Int -> Int) -> Int -> b
accumulate combiner nullValue term a next b
  | a > b     = nullValue
  | otherwise = combiner (term a)
                         (accumulate combiner nullValue term (next a) next b)
-}

accumulate :: (b -> a -> b) -> b -> (Int -> a) ->
              Int -> (Int -> Int) -> Int -> b
accumulate combiner nullValue term a next b
  | a > b     = nullValue
  | otherwise = accumulate combiner (combiner nullValue (term a))
                term (next a) next b
