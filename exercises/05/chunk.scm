(require rackunit rackunit/text-ui)

; Би било много удобно, ако разполагахме с готова функция,
; която отчупва частица (chunk) с произволна големина n
; от подадения списък l.
; За наша радост има 2 такива функции - take и drop.
; take дава нов списък с първите n елемента на списъка l,
; а drop дава останалата част на списъка.
(define (chunk l n)
  (define (iter chunks remaining size)
    (cond ((null? remaining)
            chunks)
          ((< size n)
            (iter (cons remaining chunks) '() 0))
          (else
            (iter (cons (take remaining n) chunks)
                        (drop remaining n)
                        (- size n)))))
  (reverse (iter '() l (length l))))

(define chunk-tests
  (test-suite
    "Tests for chunk"

    (check-equal? (chunk '() 42) '())
    (check-equal? (chunk '(1 2) 3) '((1 2)))
    (check-equal? (chunk '(1 2 3 4 5 6) 2) '((1 2) (3 4) (5 6)))
    (check-equal? (chunk '(1 2 3 4 5 6) 3) '((1 2 3) (4 5 6)))
    (check-equal? (chunk '(1 2 3 4 5 6 7 8) 3) '((1 2 3) (4 5 6) (7 8)))))

(run-tests chunk-tests)
