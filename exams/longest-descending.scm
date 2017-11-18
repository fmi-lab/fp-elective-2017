(require rackunit rackunit/text-ui)

; Задача.
; Да се напише функция (longest-descending l), която намира низходящо сортиран
; подсписък на списъка от числа l с максимална дължина. Ако съществуват няколко
; такива подсписъка, функцията да върне първия отляво надясно.

; Идеята е да намерим първия най-дълъг от най-дългите низходящо сортирани
; префикси на суфиксите на l. Тоест за всеки суфикс на l трябва да намерим
; най-дългия му префикс (низходящо сортиран) и от получените префикси трябва
; да върнем първия най-дълъг.

; Намира най-дългия низходящо сортиран префикс на списъка l.
(define (longest-descending-prefix l)
  (define (iter previous prefix l)
    (if (or (null? l) (> (car l) previous))
        (reverse prefix)
        (iter (car l) (cons (car l) prefix) (cdr l))))

  (if (null? l)
      '()
      (iter (car l) (list (car l)) (cdr l))))

; Можем да решим задачата чрез итерация по списъка l. На всяка стъпка пазим
; текущия най-дълъг низходящо сортиран префикс (max-prefix) и неговата дължина
; (max-length). На всяка стъпка аргументът l на iter е суфикс на първоначалния
; списък, до който сме стигнали.
(define (longest-descending l)
  (define (iter max-length max-prefix l)
    (let* ((current-prefix (longest-descending-prefix l))
           (current-prefix-length (length current-prefix)))
      (cond ((null? l) max-prefix)
            ((> current-prefix-length max-length)
             (iter current-prefix-length current-prefix (cdr l)))
            (else (iter max-length max-prefix (cdr l))))))

  (if (null? l)
      '()
      (let ((prefix (longest-descending-prefix l)))
        (iter (length prefix) prefix (cdr l)))))

(define longest-descending-tests
  (test-suite
   "Tests for longest-descending"

   (check-equal? (longest-descending '(5 3 8 6 4 2 8 2 1)) '(8 6 4 2))
   (check-equal? (longest-descending '(1 2 3 4 5 6)) '(1))))

(run-tests longest-descending-tests)
