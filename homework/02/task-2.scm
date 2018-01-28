(require rackunit rackunit/text-ui)

(define (remove-at l index)
  (define-values (before after) (split-at l index))

  (append before (cdr after)))

(define (remove-column matrix index)
  (map (lambda (row) (remove-at row index))
       matrix))

(define (flat l)
  (cond ((null? l) '())
        ((list? (car l))
         (append (car l) (flat (cdr l))))
        (else (cons (car l) (flat (cdr l))))))

(define (cross-out matrix)
  (define rows-count (length matrix))
  (define row-indices (range 0 rows-count))

  (define columns-count (length (car matrix)))
  (define column-indices (range 0 columns-count))

  (flat (map (lambda (crossed-row-index)
               (define other-rows (remove-at matrix crossed-row-index))

               (map (lambda (crossed-column-index)
                      (remove-column other-rows crossed-column-index))
                    column-indices))
             row-indices)))

(define (exists? p? l)
  (foldl (lambda (x acc) (or (p? x) acc)) #f l))

(define (cross-out? matrix result)
  (define generated (cross-out matrix))

  (exists? (lambda (permutation)
             (equal? permutation generated))
           (permutations result)))

(define task-2-tests
  (test-suite
   "Tests for task 2"

   (check-true (cross-out? '((1 2)
                             (3 4))
                           '(((4))
                             ((3))
                             ((2))
                             ((1)))))

   (check-true (cross-out? '((1 2 3)
                             (4 5 6))
                           '(((5 6))
                             ((4 6))
                             ((4 5))
                             ((2 3))
                             ((1 3))
                             ((1 2)))))

   (check-true (cross-out? '((1 2)
                             (3 4)
                             (5 6))
                           '(((4) (6))
                             ((3) (5))
                             ((2) (6))
                             ((1) (5))
                             ((2) (4))
                             ((1) (3)))))

   (check-true (cross-out? '((1 2 3)
                             (4 5 6)
                             (7 8 9))
                           '(((5 6) (8 9))
                             ((4 6) (7 9))
                             ((4 5) (7 8))
                             ((2 3) (8 9))
                             ((1 3) (7 9))
                             ((1 2) (7 8))
                             ((2 3) (5 6))
                             ((1 3) (4 6))
                             ((1 2) (4 5)))))))

(run-tests task-2-tests)
