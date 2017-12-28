(require rackunit rackunit/text-ui)

(define (average a b)
  (/ (+ a b) 2.0))

(define (approx-zero? x eps)
  (< (abs x) eps))

(define (binary-search f a b eps)
  (define (helper a b iteration)
    (let* ((mid (average a b))
           (f-mid (f mid)))
      (cond ((or (approx-zero? f-mid eps)
                 (approx-zero? (- b a) eps))
             (cons mid iteration))
            ((< (* (f a) f-mid) 0) (helper a mid (+ iteration 1)))
            (else (helper mid b (+ iteration 1))))))

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
  (define (derive f)
    (define dx 1e-6)

    (lambda (x)
      (/ (- (f (+ x dx))
            (f x))
         dx)))

  (define f-derived (derive f))

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
  (list (cdr (binary-search f a b eps))
        (cdr (secant-method f a b eps))
        (cdr (newton-method f a b eps))))

(define eps 1e-6)

(compare-methods (lambda (x) (- (exp x) (* 3 x))) 0 1 eps)
(compare-methods (lambda (x) (expt (- x 2) 3)) 0 5 1e-1)
(compare-methods (lambda (x) (- (sqrt x) (* 2 (log x)))) 1 5 eps)
(compare-methods (lambda (x) (- (exp (sqrt x)) (* 2 x))) 5 10 eps)

(define task-3-tests
  (test-suite
   "Tests for task 3"

   (check-= (car (find-root (lambda (x) (- (exp x) (* 3 x))) 0 1 eps))
            0.6191 1e-4)
   (check-= (car (find-root (lambda (x) (expt (- x 2) 3)) 0 5 eps))
            2 eps)
   (check-= (car (find-root (lambda (x) (- (sqrt x) (* 2 (log x)))) 1 5 eps))
            2.044 1e-3)
   (check-= (car (find-root (lambda (x) (- (exp (sqrt x)) (* 2 x))) 5 10 eps))
            6.853 1e-3)))

(run-tests task-3-tests)
