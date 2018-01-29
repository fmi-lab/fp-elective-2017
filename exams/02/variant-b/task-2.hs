data Tree a = Empty | Node a (Tree a) (Tree a) deriving Show

treeMap :: Tree a -> (a -> b) -> Tree b
treeMap Empty _ = Empty
treeMap (Node x l r) f = Node (f x) (treeMap l f) (treeMap r f)

clone :: Num a => Tree a -> a -> a -> Tree a
clone t x y = Node x increased increased
  where increased = treeMap t (+ y)

cloningTrees :: Num t => [Tree t]
cloningTrees =
  Node 1 Empty Empty : map (\ t@(Node x _ _) -> clone t x 1) cloningTrees
