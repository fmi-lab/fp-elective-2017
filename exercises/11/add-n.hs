{-
add :: Num a => a -> a -> a
add x y = x + y
-}
 
{-
addN :: Num a => a -> a -> a
addN n = add n
-}

{-
addN :: Num a => a -> a -> a
addN n = (+) n
-}

{-
addN :: Num a => a -> a -> a
addN n = (+ n)
-}

addN :: Num a => a -> a -> a
addN = (+)
