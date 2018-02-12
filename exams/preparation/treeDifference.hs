{-
 - Дадено е двоично наредено дърво, в което всеки връх съдържа цяло число и
 - разликата на височините на двете му поддървета.
 - Да се напише функция specialInsert x tree, която добавя връх със стойност
 - x в двоичното наредено дърво tree (като правилно обновява разликите във
 - височините за всеки връх).
 -}


data Tree a = Empty | Node Int a (Tree a) (Tree a) deriving (Show)

tree = (Node 0 10 (Node 0 6 Empty Empty)
                  (Node 0 15 Empty Empty))

treeInsert :: Ord a => Tree a -> a -> Tree a
treeInsert Empty x = (Node 0 x Empty Empty)
treeInsert (Node diff root left right) x
  | x < root  = (Node diff root (treeInsert left x) right)
  | otherwise = (Node diff root left (treeInsert right x))

updateDiffs :: Tree a -> Tree a
updateDiffs Empty = Empty
updateDiffs (Node _ root left right) =
  (Node heightDiff root (updateDiffs left) (updateDiffs right))
    where heightDiff = abs ((height left) - (height right))

height :: Tree a -> Int
height Empty = 0
height (Node _ _ left right) = 1 + max (height left) (height right)

specialInsert x tree = updateDiffs $ treeInsert tree x
