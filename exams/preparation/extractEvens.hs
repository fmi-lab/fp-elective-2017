{- Да се напише функция extractEvens string, която връща списък от всички
 - четни числа в низа string.
 -}


extractEvens :: String -> [String]
extractEvens [] = []
extractEvens s@(c:cs)
  | isDigit c && isNumberEven s =
    extractNumber s : extractEvens (dropWhile isDigit s)
  | otherwise = extractEvens cs
    where extractNumber s = (takeWhile isDigit s)
          lastDigit     s = last s
          isNumberEven  s = last (extractNumber s) `elem` ['0', '2'..'9']

isDigit :: Char -> Bool
isDigit c = c `elem` ['0'..'9']
