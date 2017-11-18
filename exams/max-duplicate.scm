(require rackunit rackunit/text-ui)

(define (identity x) x)

(define (1+ x) (+ x 1))

(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

(define (filter p? l)
  (cond ((null? l) '())
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (foldl combiner null-value l)
  (if (null? l)
      null-value
      (foldl combiner (combiner (car l) null-value) (cdr l))))

(define (max-or-false l)
  (if (null? l)
      #f
      (foldl (lambda (curr max)
               (if (> curr max) curr max))
             (car l) (cdr l))))

(define (max-duplicate ll)
  (define (duplicate? x l)
    (> (foldl (lambda (curr count)
                (if (= curr x) (1+ count) count))
              0 l)
       1))

  (define (duplicates l)
    (filter (lambda (x) (duplicate? x l)) l))

  (define (max-duplicate* l)
    (max-or-false (duplicates l)))

  (max-or-false (filter identity (map max-duplicate* ll))))

(define max-duplicate-tests
  (test-suite
   "Tests for max-duplicate"

   (check = (max-duplicate '((1 2 3 2) (-4 -4) (5))) 2)
   (check = (max-duplicate '((1 2 3) (-4 -4) (5 2) (5 6))) -4)

   (check-false (max-duplicate '((1 2 3) (-4 -5 -6) ())))
   (check-false (max-duplicate '((1 2 3) (-4 -5 -6) (2))))))

(run-tests max-duplicate-tests)
