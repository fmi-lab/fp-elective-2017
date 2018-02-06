import Data.List (subsequences, permutations)

check :: [Int -> Int] -> [Int] -> Int
check fs ns =
  maximum [length fsChain | fsSubset <- subsequences fs,
                            fsChain <- permutations fsSubset,
                            f <- fs,
                            all (\ n -> (compose fsChain n) == f n) ns]
    where compose = foldl (.) id
