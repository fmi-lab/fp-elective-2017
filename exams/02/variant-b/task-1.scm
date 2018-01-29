(require rackunit rackunit/text-ui)

(define (for-all? p? l)
  (foldl (lambda (x acc) (and (p? x) acc)) #t l))

(define (extremum ll)
  (define minimums (map (lambda (l) (apply min l)) ll))
  (define maximums (map (lambda (l) (apply max l)) ll))

  (define (all-extrema-same-as? x)
    (for-all? (lambda (min-max)
                (or (= (car min-max) x) (= (cdr min-max) x)))
              (map cons minimums maximums)))

  (cond ((null? ll) 0)
        ((all-extrema-same-as? (car minimums)) (car minimums))
        ((all-extrema-same-as? (car maximums)) (car maximums))
        (else 0)))

(define middle-digits-tests
  (test-suite
   "Tests for middle-digits"

   (check = (extremum '((1 2 3 2) (3 5) (3 3) (1 1 3 3))) 3)
   (check = (extremum '((1 2 3 2) (1 3 5) (0 1) (1 1 3 3))) 1)
   (check = (extremum '((0 0 3 2) (0 3 5) (0 1) (1 1 0 3))) 0)
   (check = (extremum '((1 2 3 2) (2 3 5) (3 3) (2 2 3 3))) 0)))

(run-tests middle-digits-tests)
