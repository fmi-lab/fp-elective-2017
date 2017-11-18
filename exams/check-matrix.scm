(require rackunit rackunit/text-ui)

(define (foldl combiner null-value l)
  (if (null? l)
      null-value
      (foldl combiner (combiner (car l) null-value) (cdr l))))

(define (for-all? p? l)
  (foldl (lambda (x acc) (and (p? x) acc)) #t l))

(define (exists? p? l)
  (foldl (lambda (x acc) (or (p? x) acc)) #f l))

(define (check-matrix? m k)
  (define (divides? x)
    (zero? (remainder x k)))

  (for-all? (lambda (row) (exists? divides? row)) m))

(define check-matrix?-tests
  (test-suite
   "Tests for check-matrix?"

   (check-true (check-matrix? '((1 2 6) (3 8 9) (10 12 11)) 3))
   (check-false (check-matrix? '((1 2 4) (3 8 9) (10 12 11)) 3))))

(run-tests check-matrix?-tests)
