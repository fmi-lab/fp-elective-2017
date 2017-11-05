(require rackunit rackunit/text-ui)

(define remove-duplicates-tests
  (test-suite
    "Tests for remove-duplicates"

    (check = (remove-duplicates '(42)) '(42))
    (check = (remove-duplicates '(6 6 6)) '(6))
    (check = (remove-duplicates '(1 2 3 4 5 6)) '(1 2 3 4 5 6))
    (check = (remove-duplicates '(4 3 3 2 5 2)) '(4 3 2 5))
    (check = (remove-duplicates '(10 10 8 2 2 2 9 9)) '(10 8 2 9))
))

(run-tests remove-duplicates-tests)
