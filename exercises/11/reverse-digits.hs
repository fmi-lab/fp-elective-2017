reverseDigits :: Integral a => a -> a
reverseDigits n = iter n 0
  where
    iter 0 acc = acc
    iter n acc = iter (stripDigit n) (appendDigit (lastDigit n) acc)
    lastDigit  = (`mod` 10)
    stripDigit = (`div` 10)
    appendDigit d = (+ d) . (* 10)
