(require rackunit rackunit/text-ui)

(define (reduce n)
  (define (last-digit n)
    (remainder n 10))

  (define (without-last-digit n)
    (quotient n 10))

  (define (append-digit n d)
    (+ (* n 10) d))

  (define (digit-count n)
    (if (< n 10)
        1
        (+ 1 (digit-count (without-last-digit n)))))

  (define (ith-digit n i)
    (if (= i 0)
        (last-digit n)
        (ith-digit (without-last-digit n) (- i 1))))

  (define (largest-digit-index n)
    (argmax (lambda (i) (ith-digit n i))
            (reverse (range 0 (digit-count n)))))

  (define (without-ith-digit n i)
    (if (= i 0)
        (without-last-digit n)
        (append-digit (without-ith-digit (without-last-digit n) (- i 1))
                      (last-digit n))))

  (if (< n 10)
      n
      (let ((index (largest-digit-index n)))
        (reduce (* (ith-digit n index)
                   (without-ith-digit n index))))))

(define task-2-tests
  (test-suite
   "Tests for task 2"

   (check = (reduce 0) 0)
   (check = (reduce 9) 9)
   (check = (reduce 27) 4)
   (check = (reduce 757) 5)
   (check = (reduce 1234) 8)
   (check = (reduce 26364) 8)
   (check = (reduce 432969) 0)
   (check = (reduce 1234584) 8)
   (check = (reduce 91273716) 6)))

(run-tests task-2-tests)
