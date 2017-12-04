(require rackunit rackunit/text-ui "test-helpers.scm" "stream.scm")

(define primes-tests
  (test-suite
   "Tests for primes"

   (check = prime-42th 181)))

(run-tests primes-tests)
