(require rackunit rackunit/text-ui)

(define (make-tree root children) (cons root children))
(define (make-leaf root) (make-tree root '()))

(define root-tree car)
(define children cdr)
(define left-tree cadr)
(define right-tree caddr)

(define (expr->tree expr)
  (if (or (number? expr) (symbol? expr))
      (make-leaf expr)
      (make-tree (car expr)
                 (map expr->tree (cdr expr)))))

(define (tree-eval tree x)
  (define root (root-tree tree))
  (define (tree-eval-child child) (tree-eval child x))

  (cond ((number? root) root)
        ((eq? root 'x) x)
        (else (apply (eval (root-tree tree))
                     (map tree-eval-child (children tree))))))

(define (tree-derive-sum tree)
  (make-tree '+ (map tree-derive (children tree))))

(define (tree-derive-difference tree)
  (make-tree '- (map tree-derive (children tree))))

(define (tree-derive-product tree)
  (define (derive-two left right)
    (make-tree '+
               (list (make-tree '* (list (tree-derive left) right))
                     (make-tree '* (list (tree-derive right) left)))))

  (derive-two (car (children tree))
              (if (> (length (children tree)) 2)
                  (make-tree '* (drop (children tree) 1))
                  (cadr (children tree)))))

(define (tree-derive-quotient tree)
  (define left (left-tree tree))
  (define right (right-tree tree))

  (make-tree '/
             (list (make-tree '-
                              (list (make-tree '*
                                               (list (tree-derive left)
                                                     right))
                                    (make-tree '*
                                               (list (tree-derive right)
                                                     left))))
                   (make-tree '* (list right right)))))

(define (tree-derive-expt tree)
  (define left (left-tree tree))
  (define right (right-tree tree))

  (make-tree '*
             (list (make-tree 'exp
                              (list (make-tree '*
                                               (list right
                                                     (make-tree 'log
                                                                (list left))))))
                   (make-tree '+
                              (list (make-tree '*
                                               (list (tree-derive right)
                                                     (make-tree 'log
                                                                (list left))))
                                    (make-tree '/
                                               (list
                                                (make-tree '*
                                                           (list right
                                                                 (tree-derive
                                                                  left)))
                                                left)))))))

(define (tree-derive-sqrt tree)
  (make-tree '/
             (list (tree-derive (left-tree tree))
                   (make-tree '* (list (make-leaf 2) tree)))))

(define (tree-derive-log tree)
  (make-tree '/
             (list (tree-derive (left-tree tree))
                   (left-tree tree))))

(define (tree-derive-exp tree)
  (make-tree '*
             (list tree
                   (tree-derive (left-tree tree)))))

(define (tree-derive tree)
  (define root (root-tree tree))

  (cond ((number? root) (make-leaf 0))
        ((eq? root 'x) (make-leaf 1))
        ((eq? root '+) (tree-derive-sum tree))
        ((eq? root '-) (tree-derive-difference tree))
        ((eq? root '*) (tree-derive-product tree))
        ((eq? root '/) (tree-derive-quotient tree))
        ((eq? root 'expt) (tree-derive-expt tree))
        ((eq? root 'sqrt) (tree-derive-sqrt tree))
        ((eq? root 'log) (tree-derive-log tree))
        ((eq? root 'exp) (tree-derive-exp tree))))

(define task-3-tests
  (test-suite
   "Tests for task 3"

   (check = (tree-eval (expr->tree 1) 0) 1)
   (check = (tree-eval (expr->tree 'x) 0) 0)
   (check = (tree-eval (expr->tree '(* 2 3)) 3) 6)
   (check = (tree-eval (expr->tree '(* x x)) 5) 25)
   (check = (tree-eval (expr->tree '(* 2 x)) 5) 10)
   (check = (tree-eval (expr->tree '(- (/ (expt x 5) (+ (* 2 x) 4)) 1)) 2) 3)

   (check = (tree-eval (tree-derive (expr->tree 1)) 0) 0)
   (check = (tree-eval (tree-derive (expr->tree 'x)) 0) 1)
   (check = (tree-eval (tree-derive (expr->tree '(* 2 3))) 3) 0)
   (check = (tree-eval (tree-derive (expr->tree '(* x x))) 5) 10)
   (check = (tree-eval (tree-derive (expr->tree '(* 2 x))) 5) 2)
   (check = (tree-eval (tree-derive (expr->tree '(+ (* x x) x))) 5) 11)
   (check = (tree-eval (tree-derive (expr->tree '(- (* x x) x))) 5) 9)
   (check = (tree-eval (tree-derive (expr->tree '(/ 2 x))) 1) -2)
   (check = (tree-eval (tree-derive (expr->tree '(/ 2 x))) 5) -2/25)
   (check = (tree-eval (tree-derive (expr->tree '(/ 2 (* x x)))) 3) -4/27)
   (check = (tree-eval (tree-derive (expr->tree '(/ x 2))) 5) 1/2)
   (check = (tree-eval (tree-derive (expr->tree '(expt (* x x) 5))) 2) 5120)

   (check = (tree-eval (expr->tree '(sqrt (+ x 1))) 3) 2)
   (check-= (tree-eval (expr->tree '(log (+ x 1))) 9) 2.3 0.1)
   (check-= (tree-eval (expr->tree '(exp (* x 2))) 1) 7.3 0.1)

   (check = (tree-eval (tree-derive (expr->tree '(sqrt (+ x 1)))) 3) 1/4)
   (check = (tree-eval (tree-derive (expr->tree '(log (+ x 1)))) 9) 1/10)
   (check-= (tree-eval (tree-derive (expr->tree '(exp (* x 2)))) 1) 14.7 0.1)
   
   (check = (tree-eval (expr->tree '(+ 1 2 3 (- x 1))) 5) 10)
   (check = (tree-eval (expr->tree '(* 1 2 3 (/ x 2))) 8) 24)

   (check = (tree-eval
              (tree-derive
                (expr->tree '(+ x (* 2 x) (* 3 x) (- (* 4 x) 1))))
              5)
          10)
   (check = (tree-eval (tree-derive (expr->tree '(* x x x (/ x 2)))) 2) 16)

   (check = (tree-eval (expr->tree '(expt 2 (* x 5))) 2) 1024)
   (check = (tree-eval (expr->tree '(expt (* x x) (- x 1))) 3) 81)

   (check-= (tree-eval (tree-derive (expr->tree '(expt 2 (* x 5)))) 2)
            3548.9
            0.1)
   (check-= (tree-eval (tree-derive (expr->tree '(expt (* x x) (* x 5)))) 2)
            17753934.9
            0.1)))

(run-tests task-3-tests)
