(require rackunit rackunit/text-ui)

; Условие: https://learn.fmi.uni-sofia.bg/mod/page/view.php?id=62524

; Задача 1. Да се напише функция (min-sum-digit a b k), която
; намира най-малкото от целите числа от a да b,
; чиято сума на цифрите се дели на k

(define (sum-digits n)
  (define (iter digits sum)
    (if (= digits 0)
        sum
        (iter (quotient digits 10)
              (+ sum
                 (remainder digits 10)))))
  (iter n 0))

; (range 1 5) -> '(1 2 3 4)
; (filter even? '(1 2 3 4)) -> '(2 4)
; (min 9 2 3 1 4) -> 1
; range |> map |> filter |> min
(define (min-sum-digit a b k)
  (define (digit-sum-divisible-by-k? number)
    (zero? (remainder (sum-digits number) k)))

  (define numbers (range a (+ b 1)))

  (define divisible (filter digit-sum-divisible-by-k? numbers))

  (apply min divisible))

; Забележка: accumulate също може да се използва за решаването на задачата,
; където null-value ще бъде максималното цяло число

(define min-sum-digit-tests
  (test-suite
    "Tests for min-sum-digit"

    (check = (min-sum-digit 1 5 3) 3)
    (check = (min-sum-digit 1 7 2) 2)
    (check = (min-sum-digit 11 16 3) 12)
))

(run-tests min-sum-digit-tests)
