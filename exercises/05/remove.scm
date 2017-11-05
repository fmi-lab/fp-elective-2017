(require rackunit rackunit/text-ui)

(define remove-tests
  (test-suite
    "Tests for remove"

    (check = (remove '(42) 42) '())
    (check = (remove '(5 3 5 5) 5) '(3 5 5))
    (check = (remove '(8 4 92 82 8 13) 82) '(8 4 92 8 13))
    (check = (remove '(8 4 82 12 31 133) 133) '(8 4 82 12 31))
))

(run-tests remove-tests)
