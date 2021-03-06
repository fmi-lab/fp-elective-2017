Упражнение 13
=============

1. Да се дефинира тип `Tree`, представящ двоично дърво, съдържащо стойности от
произволен тип във възлите си.

2. Да се дефинира функция `treeSize(t)`, която приема за аргумент двоично
дърво `t` и намира броя възли на `t`.

3. Да се дефинира функция `treeSum(t)`, която приема за аргумент двоично дърво
`t` с числа във възлите и намира сумата на всички възли на `t`.

4. Да се дефинира функция `maxSumPath(t)`, която приема за аргумент двоично
дърво `t` с числа във възлите и намира максималната сума на числата по някой
път от корен до листо.

5. Да се дефинира функция `prune(t)`, която по дадено двоично дърво `t` връща
ново дърво `t'`, което представлява `t`, в което всички листа са премахнати.

6. Да се напише функция `bloom(t)`, която по дадено двоично дърво `t` връща
ново дърво `t'`, което представлява `t`, в което на всички листа са добавени
по два наследника - нови листа. Стойността в тези нови листа да е същата като в
оригиналното листо от `t`, на което са наследници.

7. Да се дефинира тип `BST`, който да представлява двоично наредено дърво,
съдържащо стойности от произволен тип във възлите си. Да се дефинират следните
функции към него:
- bstInsert :: (Ord a) => a -> BST a -> BST a - добавяне на стойност в дървото
- bstSearch :: (Ord a) => a -> BST a -> Bool - търсене на стойност в дървото
- bstSize :: BST a -> Int - брой стойности в дървото
- bstFromList :: (Ord a) => [a] -> BST a - получаване на двоично наредено дърво
от списък със стойности
- bstToList :: BST a -> [a] - получаване на списък с всички стойности в дървото

8. Да се дефинира тип `Map`, който да представлява структурата от данни map,
реализирана с двоично наредено дърво. Да се дефинират следните функции към нея:
- mapInsert :: (Ord k) => k -> v -> Map k v -> Map k v - вмъкване на ключ със
стойност в дървото. Ако стойност за този ключ съществува, нека тя да бъде
заместена с новата.
- mapSearch :: (Ord k) => k -> Map k v -> Maybe v - търсене на стойност по ключ
в дървото (обърнете внимание на типа на връщане)
- mapSize :: Map k v -> Int - брой наредени двойки (ключ, стойност) в дървото
- mapFromList :: (Ord k) => [(k, v)] -> Map k v - получаване на map от списък
от наредени двойки (ключ, стойност)
- mapToList :: Map k v -> [(k, v)] - получаване на списък с всички наредени
двойки (ключ, стойност), съдържащи се в map
