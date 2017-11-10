(require rackunit rackunit/text-ui)

(define (remove l x)
  (define (iter checked rest)
    (cond ((or (null? rest)
               (not (eq? (car rest) x)))
           (iter (cons (car rest) checked)
                 (cdr rest)))
          ((eq? (car rest) x)
           (append (reverse checked)
                   (cdr rest)))))

  (iter '() l))

(define remove-tests
  (test-suite
    "Tests for remove"

    (check-equal? (remove '(42) 42) '())
    (check-equal? (remove '(5 3 5 5) 5) '(3 5 5))
    (check-equal? (remove '(8 4 92 82 8 13) 82) '(8 4 92 8 13))
    (check-equal? (remove '(8 4 82 12 31 133) 133) '(8 4 82 12 31))))

(run-tests remove-tests)
