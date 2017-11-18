(require rackunit rackunit/text-ui)

; Задача.
; Да се напише функция (max-duplicate ll), която по списък от списъци от
; цели числа ll намира най-голямото от тези числа, които се повтарят в
; рамките на списъка, в който се срещат. Ако в нито един списък няма
; повтарящи се числа, функцията да връща #f.

; За решаването на задачата ще използваме функциите от по-висок ред за работа
; със списъци map, filter и foldl.

(define (identity x) x)

(define (1+ x) (+ x 1))

(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

(define (filter p? l)
  (cond ((null? l) '())
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (foldl combiner null-value l)
  (if (null? l)
      null-value
      (foldl combiner (combiner (car l) null-value) (cdr l))))

; Нека имаме списъка от списъци ((1 2 3 2) (-4 -4) (5)). Като приложим
; max-duplicate върху ((1 2 3 2) (-4 -4) (5)), трябва да получим 2. За да
; достигнем до този отговор, ще направим следните трансформации върху входния
; списък:
; ((1 2 3 2) (-4 -4) (5)) -> (2 -4 #f) -> (2 -4) -> 2
; За първата трансформация трябва да имаме функция (max-duplicate-or-false l),
; която намира максималния повтарящ се елемент в списък от числа l или
; връща #f, ако няма такъв. Използвайки map и max-duplicate-or-false, можем
; да извършим първата трансформация. Втората трансформация премахва всички
; #f стойности от получения списък (за нея можем да използваме filter). За
; последната трансформация трябва да намерим максималния елемент в списъка,
; ако има такъв (ако списъка е празен, трябва да върнем #f).

; Намира максималния елемент в списъка l или връща #f, ако няма такъв (това
; се случва, когато l е празен).
(define (max-or-false l)
  (and (not (null? l))
       (apply max l)))

(define (max-duplicate ll)
  ; Проверява дали x се среща повече от веднъж в l. Чрез foldl броим срещанията
  ; на x в l и проверяваме дали този брой е повече от 1.
  (define (duplicate? x l)
    (> (foldl (lambda (curr count)
                (if (= curr x) (1+ count) count))
              0 l)
       1))

  ; Използвайки предиката duplicate?, конструираме списък само от тези
  ; елементи, които се повтарят в l (т.е. които удовлетворяват duplicate?).
  (define (duplicates l)
    (filter (lambda (x) (duplicate? x l)) l))

  ; Сега можем да дефинираме max-duplicate-or-false (която използваме за
  ; първата трансформация), чрез max-or-false и duplicates.
  (define (max-duplicate-or-false l)
    (max-or-false (duplicates l)))

  ; Извършваме гореописаните трансформации.
  (max-or-false (filter identity (map max-duplicate-or-false ll))))

(define max-duplicate-tests
  (test-suite
   "Tests for max-duplicate"

   (check = (max-duplicate '((1 2 3 2) (-4 -4) (5))) 2)
   (check = (max-duplicate '((1 2 3) (-4 -4) (5 2) (5 6))) -4)

   (check-false (max-duplicate '((1 2 3) (-4 -5 -6) ())))
   (check-false (max-duplicate '((1 2 3) (-4 -5 -6) (2))))))

(run-tests max-duplicate-tests)
