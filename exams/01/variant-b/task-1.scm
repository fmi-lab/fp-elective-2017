(require rackunit rackunit/text-ui)

(define (middle-digits n)
  (define (last-digit n)
    (remainder n 10))

  (define (without-last-digit n)
    (quotient n 10))

  (define (append-digit n d)
    (+ (* 10 n) d))

  (define (digit-count n)
    (if (< n 10)
        1
        (+ 1 (digit-count (without-last-digit n)))))

  (define (ith-digit n i)
    (if (= i 0)
        (last-digit n)
        (ith-digit (without-last-digit n) (- i 1))))

  (let ((count (digit-count n)))
    (if (odd? count)
        -1
        (append-digit (ith-digit n (/ count 2))
                      (ith-digit n (- (/ count 2) 1))))))

(define middle-digits-tests
  (test-suite
   "Tests for middle-digits"

   (check = (middle-digits 0) -1)
   (check = (middle-digits 1) -1)
   (check = (middle-digits 452) -1)
   (check = (middle-digits 45241) -1)

   (check = (middle-digits 42) 42)
   (check = (middle-digits 4712) 71)
   (check = (middle-digits 471239) 12)))

(run-tests middle-digits-tests)
