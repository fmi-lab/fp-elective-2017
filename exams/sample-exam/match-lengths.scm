(require rackunit rackunit/text-ui)

; Условие: https://learn.fmi.uni-sofia.bg/mod/page/view.php?id=62524

; Задача 4. Да се дефинира предикат (match-lenghts? l1 l2).
; l1 и l2 са непразни списъци от списъци от числа.
; Ако l1 = (a1 a2 … ak), а l2 = (b1 b2 … bk), предикатът да връща истина, когато
; разликите в дължините на всяка двойка съответни списъци ai и bi е еднаква.
;
; Пример:
; (match-lengths? ‘( () (1 2) (3 4 5)) ‘( (1) (2 3 4) (5 6 7 8))) -> #t,
; (match-lengths? ‘( () (1 2) (3 4 5)) ‘( () (2 3 4) (5 6 7))) -> #f

(define (zip a b)
  (if (or (null? a) (null? b))
      '()
      (cons (list (car a) (car b))
            (zip  (cdr a) (cdr b)))))

(define (for-all? p? l)
  (foldl (lambda (x acc) (and (p? x) acc)) #t l))


(define (match-lengths? l1 l2)
  (let ((length-differences (map (lambda (a b)
                                   (abs (- (length a)
                                           (length b))))
                                 l1
                                 l2)))
    (= (length (filter (lambda (x)
                         (= x (car length-differences)))
                       length-differences))
       (length l1))))


; 2nd solution
(define (match-lengths? l1 l2)
  (define length-differences
    (map (lambda (tuple)
           (abs (- (length (car tuple))
                   (length (cadr tuple)))))
         (zip l1 l2)))

  (for-all? (lambda (x) (= (car length-differences) x)) length-differences))


(define match-lengths?-tests
  (test-suite
    "Tests for match-lengths?"

    (check-true (match-lengths? '(() (1 2) (3 4 5)) '((1) (2 3 4) (5 6 7 8))))
    (check-false (match-lengths? '(() (1 2) (3 4 5)) '(() (2 3 4) (5 6 7))))
))

(run-tests match-lengths?-tests)
