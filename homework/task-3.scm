(require rackunit rackunit/text-ui)

(define (average a b)
  (/ (+ a b) 2.0))

(define (signum x)
  (cond ((< x 0) -1)
        ((> x 0) 1)
        (else 0)))

(define (same-sign? x y)
  (= (signum x)
     (signum y)))

(define (approx-zero? x eps)
  (< (abs x) eps))

(define (binary-search f a b eps)
  (define (helper a b iteration)
    (let* ((mid (average a b))
           (f-mid (f mid)))
      (cond ((or (approx-zero? f-mid eps)
                 (approx-zero? (- b a) eps))
             (cons mid iteration))
            ((same-sign? (f a) f-mid) (helper mid b (+ iteration 1)))
            (else (helper a mid (+ iteration 1))))))

  (helper a b 1))

(define (secant-method f a b eps)
  (define (next-approx a b)
    (- b
       (/ (* (f b) (- b a))
          (- (f b) (f a)))))

  (define (helper a b iteration)
    (if (approx-zero? (abs (- b a)) eps)
        (cons b iteration)
        (helper b (next-approx a b) (+ iteration 1))))

  (helper a b 1))

(define (newton-method f a b eps)
  (define (derive f dx)
    (lambda (x)
      (/ (- (f (+ x dx))
            (f x))
         dx)))

  (define f-derived (derive f eps))

  (define (next-approx previous)
    (- previous
       (/ (f previous)
          (f-derived previous))))

  (define (helper a b iteration)
    (if (approx-zero? (abs (- b a)) eps)
        (cons b iteration)
        (helper b (next-approx b) (+ iteration 1))))

  (helper a (next-approx a) 1))

(define (find-root f a b eps)
  (newton-method f a b eps))

(define (compare-methods f a b eps)
  (list (binary-search f a b eps)
        (secant-method f a b eps)
        (newton-method f a b eps)))

(define eps 0.000001)

(compare-methods (lambda (x) (- (exp x) (* 3 x))) 0 1 eps)
(compare-methods (lambda (x) (expt (- x 2) 3)) 0 5 0.1)
(compare-methods (lambda (x) (- (sqrt x) (* 2 (log x)))) 1 5 eps)
(compare-methods (lambda (x) (- (exp (sqrt x)) (* 2 x))) 5 10 eps)

(define task-3-tests
  (test-suite
   "Tests for task 3"

   (check-= (car (find-root (lambda (x) (- (exp x) (* 3 x))) 0 1 eps))
            0.6191 0.0001)
   (check-= (car (find-root (lambda (x) (expt (- x 2) 3)) 0 5 eps))
            2 eps)
   (check-= (car (find-root (lambda (x) (- (sqrt x) (* 2 (log x)))) 1 5 eps))
            2.044 0.001)
   (check-= (car (find-root (lambda (x) (- (exp (sqrt x)) (* 2 x))) 5 10 eps))
            6.853 0.001)))

(run-tests task-3-tests)
