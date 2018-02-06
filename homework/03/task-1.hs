import Data.List (maximumBy)
import Data.Monoid
import Data.Ord (comparing)

type Rect = (Int, Int, Int, Int)

mostPopular :: [Rect] -> Rect
mostPopular rects = maximumBy (comparing popularity <> comparing area) rects
  where popularity rect = length [other | other <- rects, intersect other rect]
        area (x1, y1, x2, y2) = abs $ (x1 - x2) * (y1 - y2)
        intersect (l1, b1, r1, t1) (l2, b2, r2, t2) =
          r1 >= l2 && r2 >= l1 && t1 >= b2 && t2 >= b1
