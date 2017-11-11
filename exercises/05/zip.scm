(require rackunit rackunit/text-ui)

(define (zip a b)
  (if (or (null? a) (null? b))
      '()
      (cons (list (car a) (car b))
            (zip  (cdr a) (cdr b)))))

(define zip-tests
  (test-suite
    "Tests for zip"

    (check-equal? (zip '() '(6 6 6)) '())
    (check-equal? (zip '(1 2) '(3 4)) '((1 3) (2 4)))
    (check-equal? (zip '(1 1 1) '(2 2)) '((1 2) (1 2)))
    (check-equal? (zip '(1 3 5) '(2 4 6)) '((1 2) (3 4) (5 6)))
    (check-equal? (zip '(1 3 5 7 9) '(2 4 6)) '((1 2) (3 4) (5 6)))
))

(run-tests zip-tests)
