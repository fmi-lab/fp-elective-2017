(require rackunit rackunit/text-ui)

; Условие: https://learn.fmi.uni-sofia.bg/mod/page/view.php?id=62524

; Задача 3. Да се дефинира функция (occurrences l1 l2).
; l1 и l2 са списъци от числа.
; Функцията да конструира списък с броя на срещанията на всеки от елементите на l1 в l2.
; Пример: (occurrences ‘(1 2 3) ‘( 1 2 4 1 )) -> (2 1 0)

(define (accumulate l combiner null-value term)
  (if (null? l)
      null-value
      (combiner (term (car l))
                (accumulate (cdr l) combiner null-value term))))

(define (count elem l)
  (accumulate l + 0 (lambda (x) (if (eq? elem x) 1 0))))

(define (occurrences l1 l2)
  (map (lambda (x) (count x l2)) l1))


; Solution without accumulate, using lists with map, filter and length
(define (occurrences-map l1 l2)
  (define (is-equal-to elem)
    (lambda (x) (eq? x elem)))

  (map (lambda (x1) (length (filter (is-equal-to x1) l2)))
       l1))


(define occurrences-tests
  (test-suite
    "Tests for occurrences"

    (check-equal? (occurrences '(1 2 3) '(1 2 4 1)) '(2 1 0))
    (check-equal? (occurrences '(2 9 8) '(1 8 7 3 9 2 8 8 1 2)) '(2 1 3))
))

(run-tests occurrences-tests)
