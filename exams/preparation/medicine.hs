{-

Задача 4.
Лекарство се задава със наредена двойка от
име (низ) и списък от активни съставки,
зададени като наредени двойки от
име (низ) и количество в мг (цяло число).
Казваме, че лекарството A е заместител на лекарството B,
ако A има точно същите активни съставки
 като B в същата пропорция.

(4 т.) Да се реализира функция isSubstitute,
която по две дадени лекарства проверява дали едното е заместител на другото.

(6 т.) Да се реализира функция bestSubstitutes,
която по лекарство A и списък от лекарства L намира
името на "най-добрия" заместител на A в L,
чиито активни съставки са най-близки по количество
до тези на A, без да ги надхвърлят, или празният низ, ако такъв няма.

(8 т.) Да се реализира функция groupSubstitutes,
по даден списък от лекарства ги групира по “заместителство”,
т.е. връща списък от списъци от лекарства,
където всички лекарства в даден списък са заместители един на друг.

Пример: l = [("A",[("p",6),("q",9)]),("B",[("p",2),("q",3)]),("C",[("p",3)])]
isSubstitute (l!!0) (l!!1) → True   bestSubstitute (l!!0) (tail l) → "B"
groupSubstitutes l → [[("A",...),("B",...)],[("C",...)]]
-}

import Data.List (sortBy, nub, partition)
import Data.Ord (comparing)

type Ingredient = (String, Int)
type Medicine = (String, [Ingredient])

l@(a:b:_) = [("A",[("p",6),("q",9)]),
     ("B",[("p",2),("q",3)]),
     ("C",[("p",3)]),
     ("D",[("q",9), ("p",6)]),
     ("E",[("q",18), ("p",12)]),
     ("F",[("q",19), ("p",12)])]

-- 1) same ingredients
-- 2) in proportion

normalize ing = sortBy (comparing fst) ing

-- isSubstitute :: Medicine -> Medicine -> Bool
isSubstitute med1@(_, ing1) med2@(_, ing2) =
  sameIngredients && inProportion
    where [sorted1, sorted2] = map normalize [ing1, ing2]
          sameIngredients = map fst sorted1 == map fst sorted2
          inProportion = (==1) . length . nub $ zipWith (\(_, a) (_, b) -> a `div` b) sorted1 sorted2

-- equivalenceClasses :: (a -> a -> Bool) -> [a] -> [[a]]
equivalenceClasses _ [] = []
equivalenceClasses relation list@(x:xs) =
  let (firstClass, rest) = partition (relation x) list
  in firstClass : equivalenceClasses relation rest

groupSubstitutes l = equivalenceClasses isSubstitute l

main = do {
    print 42
}
