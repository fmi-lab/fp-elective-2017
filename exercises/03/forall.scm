(require rackunit rackunit/text-ui)

(define forall-tests
  (test-suite
   "Tests for forall? predicate"

   (check-true (forall? (lambda (x) (> x 0) 2 98))
   (check-true (forall? (lambda (x) (< x 0) -10 -1))
   (check-true (forall? (lambda (x) (= 0 (* x 0))) -3 15))

   (check-false (forall? (lambda (x) (= x 3)) 1 5))
   (check-false (forall? (lambda (x) (= x 13)) 1 5))
   (check-false (forall? (lambda (x) (< x 3)) -5 42))))

(run-tests forall-tests)
