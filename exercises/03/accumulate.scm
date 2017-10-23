(require rackunit rackunit/text-ui)

(define accumulate-tests
  (test-suite
   "Tests for accumulate"

   (define (identity x) x)
   (define (inc x) (+ x 1))
   (define (square x) (* x x))

   (check = (accumulate + 0 identity 1 inc 5) 15)
   (check = (accumulate + 0 square 1 inc 5) 55)

   (check = (accumulate * 0 identity 1 inc 5) 0)
   (check = (accumulate * 1 identity 0 inc 5) 0)
   (check = (accumulate * 1 identity 1 inc 5) 120)

   (check = (accumulate (lambda (x acc)
                          (if (even? x) (inc acc) acc))
                        0 identity 0 inc 10) 6)
   (check = (accumulate + 0 (lambda (x) (if (even? x) 1 0)) 0 inc 10) 6)))

(run-tests accumulate-tests)
