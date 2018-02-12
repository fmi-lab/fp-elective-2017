{-

Задача 2.

(6 т.) Да се напише функция grow t x, която
по дадено двоично дърво от числа t получава ново,
в което към всяко листо на t добавя по две нови листа
със зададена стойност x.

(6 т.) Двоично дърво наричаме “пълно”,
ако има 2^n елемента на ниво n.
Да се напише функция growingTrees,
която генерира безкраен поток от пълни дървета
с височини съответно 1, 2, 3,...,
като всички елементи на ниво n са със стойност n.

-}


data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

grow :: Tree a -> a -> Tree a
grow Empty x = (Node x Empty Empty)
grow (Node value left right) x =
     (Node value (grow left x) (grow right x))

-- completeTree n = loop Empty 0
--   where loop tree i
--          | i == n    = tree
--          | otherwise = loop (grow tree i) (i + 1)

completeTree n = foldl grow Empty [0..(n - 1)]
growingTrees = map completeTree [1..]

main = do {
    print 42
}
