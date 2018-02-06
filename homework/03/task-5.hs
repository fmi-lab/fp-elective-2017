data DFA = DFA Int [Int] (Int -> Char -> Int)

match :: DFA -> String -> Bool
match (DFA _ finalStates transition) string =
  foldl transition 0 string `elem` finalStates

data NFA = NFA Int [Int] (Int -> Char -> [Int])

match' :: NFA -> String -> Bool
match' (NFA _ finalStates transition) string =
  any (`elem` finalStates) $ foldl (\ states char -> states >>= (flip transition $ char)) [0] string
