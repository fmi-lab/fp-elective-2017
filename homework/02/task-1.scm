(require rackunit rackunit/text-ui)

(define (find-first p l)
  (define filtered (filter p l))

  (if (not (null? filtered))
      (car filtered)
      #f))

(define (insert-at l index x)
  (append (take l index) (cons x (drop l index))))

(define (row-reduce matrix)
  (define first-row-with-non-zero-first-element
    (find-first (compose not zero? car) matrix))

  (define first-row-with-non-zero-first-element-index
    (index-of matrix first-row-with-non-zero-first-element))

  (define other-rows (remove first-row-with-non-zero-first-element matrix))

  (define (scalar row)
    (- (/ (car row)
          (car first-row-with-non-zero-first-element))))

  (define (scale row scalar)
    (define (*scalar x) (* x scalar))

    (map *scalar row))

  (define (add row1 row2)
    (map + row1 row2))

  (define (eliminate row)
    (add (scale first-row-with-non-zero-first-element (scalar row))
         row))

  (insert-at (map eliminate other-rows)
             first-row-with-non-zero-first-element-index
             first-row-with-non-zero-first-element))

(define task-1-tests
  (test-suite
   "Tests for task 1"

   (check-equal? (row-reduce '((1))) '((1)))

   (check-equal? (row-reduce '((1 2) (3 4))) '((1 2) (0 -2)))
   (check-equal? (row-reduce '((3 4) (1 2))) '((3 4) (0 2/3)))
   (check-equal? (row-reduce '((1 2) (0 1))) '((1 2) (0 1)))
   (check-equal? (row-reduce '((0 1) (1 2))) '((0 1) (1 2)))

   (check-equal? (row-reduce '((1 5 2)
                               (2 3 8)
                               (-2 0 4)))
                 '((1 5 2)
                   (0 -7 4)
                   (0 10 8)))
   (check-equal? (row-reduce '((0 5 2)
                               (2 3 8)
                               (-2 0 4)))
                 '((0 5 2)
                   (2 3 8)
                   (0 3 12)))
   (check-equal? (row-reduce '((0 5 2)
                               (0 3 8)
                               (-2 0 4)))
                 '((0 5 2)
                   (0 3 8)
                   (-2 0 4)))
   (check-equal? (row-reduce '((1 5 2)
                               (0 3 8)
                               (0 0 4)))
                 '((1 5 2)
                   (0 3 8)
                   (0 0 4)))
   (check-equal? (row-reduce '((0 5 2)
                               (2 3 8)
                               (0 0 4)))
                 '((0 5 2)
                   (2 3 8)
                   (0 0 4)))))

(run-tests task-1-tests)
