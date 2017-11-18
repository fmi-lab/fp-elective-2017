(require rackunit rackunit/text-ui)

(define (longest-descending l)
  (define (longest-descending-prefix l)
    (define (iter previous prefix l)
      (cond ((null? l) '())
            ((> (car l) previous) (reverse prefix))
            (else (iter (car l) (cons (car l) prefix) (cdr l)))))

    (if (null? l)
        '()
        (iter (car l) (list (car l)) (cdr l))))

  (define (suffixes l)
    (foldl (lambda (_ acc) (cons (cdar acc) acc)) (list l) l))
  
  ()
  )

(define longest-descending-tests
  (test-suite
   "Tests for longest-descending"

   (check-equal? (longest-descending '(5 3 8 6 4 2 8 2 1)) '(8 6 4 2))
   (check-equal? (longest-descending '(1 2 3 4 5 6)) '(1))))

(run-tests longest-descending-tests)
