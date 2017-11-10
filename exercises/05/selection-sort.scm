(require rackunit rackunit/text-ui)

(define (maximum l)
  (if (null? (cdr l))
      (car l)
      (max (car l) (maximum (cdr l)))))

(define without remove)

; итеративно решение, което преизползва maximum
; използваме let, за да пресметнем максимума само веднъж
; итерацията ни дава сортирания списък в обратен ред
(define (selection-sort list)
  (define (iter sorted unsorted)
    (if (null? unsorted)
        sorted
        (let ((max (maximum unsorted)))
             (iter (cons max sorted)
                   (without max unsorted)))))
  (iter '() list))

(define selection-sort-tests
  (test-suite
    "Tests for selection-sort"

    (check-equal? (selection-sort '(42)) '(42))
    (check-equal? (selection-sort '(6 6 6)) '(6 6 6))
    (check-equal? (selection-sort '(1 2 3 4 5 6)) '(1 2 3 4 5 6))
    (check-equal? (selection-sort '(6 5 4 3 2 1)) '(1 2 3 4 5 6))
    (check-equal? (selection-sort '(3 1 4 6 2 5)) '(1 2 3 4 5 6))
    (check-equal? (selection-sort '(5 2 5 1 5 2 3)) '(1 2 2 3 5 5 5))))

(run-tests selection-sort-tests)
