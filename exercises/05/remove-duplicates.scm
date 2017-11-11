(require rackunit rackunit/text-ui)

(define (member? x l)
  (and (not (null? l))
       (or (eq? (car l) x)
           (member? x (cdr l)))))

(define (remove-duplicates l)
  (define (iter unique remaining)
    (cond ((null? remaining) unique)
          ((member? (car remaining) unique)
            (iter unique
                  (cdr remaining)))
          (else
            (iter (cons (car remaining) unique)
                  (cdr remaining)))))
  (reverse (iter '() l)))

(define remove-duplicates-tests
  (test-suite
    "Tests for remove-duplicates"

    (check-equal? (remove-duplicates '(42)) '(42))
    (check-equal? (remove-duplicates '(6 6 6)) '(6))
    (check-equal? (remove-duplicates '(1 2 3 4 5 6)) '(1 2 3 4 5 6))
    (check-equal? (remove-duplicates '(4 3 3 2 5 2)) '(4 3 2 5))
    (check-equal? (remove-duplicates '(10 10 8 2 2 2 9 9)) '(10 8 2 9))))

(run-tests remove-duplicates-tests)
