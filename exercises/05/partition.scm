(require rackunit rackunit/text-ui)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (partition predicate l)
  (cons (filter predicate l)
        (list (filter (compose not predicate) l))))

(define partition-tests
  (test-suite
    "Tests for partition"

    (check-equal? (partition even? '(1 2 3 4 5 6 7)) '((2 4 6) (1 3 5 7)))
    (check-equal? (partition odd? '(1 3 3 7 42)) '((1 3 3 7) (42)))
    (check-equal? (partition odd? '(3)) '((3) ()))
    (check-equal? (partition even? '()) '(() ()))
    (check-equal? (partition (lambda (x) (< x 4)) '(1 2 3 4 5 6 7))
                  '((1 2 3) (4 5 6 7)))))

(run-tests partition-tests)
