(require rackunit rackunit/text-ui)

(define flatten-tests
  (test-suite
    "Tests for flatten"

    (check = (flatten '((1 2) (3 4) (5 6))) '(1 2 3 4 5 6))
    (check = (flatten '((1 2) 3 (4 5) (6 7))) '(1 2 3 4 5 6 7))
    (check = (flatten '(5 3 5 5) ) '(5 3 5 5))
    (check = (flatten '(5 () 3 () 5 () 5) ) '(5 3 5 5))
))

(run-tests flatten-tests)
