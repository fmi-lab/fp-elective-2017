(require rackunit rackunit/text-ui)

(define (argopt comparator f args)
  (define (argopt-2 a b)
    (if (comparator (f a) (f b)) a b))

  (cond ((null? args) 'no-args)
        ((null? (cdr args)) (car args))
        (else (argopt-2 (argopt comparator f (cdr args))
                        (car args)))))

(define (argmax f args)
  (argopt > f args))

(define (argmin f args)
  (argopt < f args))

(define (square x) (* x x))

(define task-1-tests
  (test-suite
   "Tests for task 1"

   (check = (argmax square '(1 3 0 4 2.5 -4)) 4)
   (check = (argmax square '(1 3 0 -4 2.5 4)) -4)
   (check = (argmin square '(1 3 0 4 2.5 -4)) 0)

   (check-equal? (argmin length '((1 2) () (2 a 5 7) (2 4))) '())
   (check-equal? (argmin length '((1 2) (2 a 5 7) (2 4))) '(1 2))
   (check-equal? (argmin length '((2 4) (2 a 5 7) (1 2))) '(2 4))
   (check-equal? (argmax length '((1 2) () (2 a 5 7) (2 4))) '(2 a 5 7))))

(run-tests task-1-tests)
