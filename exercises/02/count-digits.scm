(require rackunit rackunit/text-ui)



(define count-digits-tests
  (test-suite
   "Tests for count-digits"

   (check = (count-digits 3) 1)
   (check = (count-digits 12) 2)
   (check = (count-digits 42) 2)
   (check = (count-digits 666) 3)
   (check = (count-digits 1337) 4)
   (check = (count-digits 65510) 5)
   (check = (count-digits 8833443388) 10)))

(run-tests count-digits-tests)
