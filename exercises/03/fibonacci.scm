(require rackunit rackunit/text-ui)

(define fibonacci-tests
  (test-suite
   "Tests for fibonacci"

   (check = (fibonacci 0) 0)
   (check = (fibonacci 1) 1)
   (check = (fibonacci 2) 1)
   (check = (fibonacci 3) 2)
   (check = (fibonacci 4) 3)
   (check = (fibonacci 5) 5)
   (check = (fibonacci 6) 8)
   (check = (fibonacci 7) 13)
   (check = (fibonacci 20) 6765)))

(run-tests fibonacci-tests)
