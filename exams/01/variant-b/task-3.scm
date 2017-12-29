(require rackunit rackunit/text-ui)

(define (is-sur? domain codomain f)
  (define (for-all? l p?)
    (foldl (lambda (x acc) (and (p? x) acc)) #t l))

  (define (exists? l p?)
    (not (for-all? l (compose not p?))))

  (define transforms?
    (for-all? domain (lambda (x) (member (f x) codomain))))

  (define covers?
    (for-all? codomain (lambda (y)
                         (exists? domain (lambda (x) (= (f x) y))))))

  (and transforms? covers?))

(define (square x) (* x x))
(define (identity x) x)

(define is-sur?-tests
  (test-suite
   "Tests for is-sur?"

   (check-true (is-sur? '() '() square))
   (check-true (is-sur? '(0 1 2 3) '(0 3 2 1) identity))
   (check-true (is-sur? '(0 1 -1 2) '(0 1 4) square))

   (check-false (is-sur? '() '(0 1 4) square))
   (check-false (is-sur? '(0 1 -1 2) '() square))
   (check-false (is-sur? '(0 1 2 3) '(0 1 2) identity))
   (check-false (is-sur? '(0 1 2) '(0 1 2 3) identity))
   (check-false (is-sur? '(0 1 -1 2 3) '(0 1 4) square))
   (check-false (is-sur? '(0 1 -1 2) '(0 1 4 9) square))))

(run-tests is-sur?-tests)
