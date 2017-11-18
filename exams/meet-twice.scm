(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (define (iter acc a)
    (if (> a b)
        acc
        (iter (combiner (term a) acc) (next a))))

  (iter null-value a))

(define (1+ x) (+ x 1))

(define (meet-twice? f g a b)
  (define (meet-in? x)
    (= (f x) (g x)))

  (define meetings-count
    (accumulate + 0 (lambda (x) (if (meet-in? x) 1 0)) a 1+ b))

  (> meetings-count 1))

(define (identity x) x)
(define (negate x) (- x))

(define meet-twice?-tests
  (test-suite
   "Tests for meet-twice?"

   (check-false (meet-twice? identity negate 0 0))
   (check-false (meet-twice? identity negate -3 1))
   (check-true (meet-twice? identity sqrt 0 5))))

(run-tests meet-twice?-tests)
