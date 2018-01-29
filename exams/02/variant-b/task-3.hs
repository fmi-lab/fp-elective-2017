import Data.List (maximumBy, subsequences, permutations, nub)
import Data.Function (on)

type TVShow = (String, (Int, Int), Int)
type TVProgram = [TVShow]

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x : y : rest) = x <= y && isSorted (y : rest)

isProgram :: TVProgram -> Bool
isProgram shows = isSorted times
  where interval (_, (h, m), duration) = [h * 60 + m, h * 60 + m + duration]
        times = concatMap interval shows

diversestProgram :: TVProgram -> TVProgram
diversestProgram shows =
  maximumBy (compare `on` diversity)
            [program | showsSubset <- subsequences shows,
                       program <- permutations showsSubset,
                       isProgram program]
    where diversity program =
            length $ nub $ map (\ (name, _, _) -> name) program
