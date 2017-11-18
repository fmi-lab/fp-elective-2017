(require rackunit rackunit/text-ui)

; Задача.
; Да се напише функция (check-matrix? m k), която проверява дали на всеки ред
; в дадена матрица m от цели числа има поне по едно число, кратно на k.

; Можем да си преведем условието на задачата по следния начин:
; ∀row∈m(∃x∈row(k | x)) (за всеки ред row от матрицата m е изпълнено, че
; съществува число x, такова че k дели x).
; Доста удобно е да си дефинираме функции от по-висок ред for-all? (∀) и
; exists? (∃), които ще проверяват съответно дали всеки елемент от даден
; списък удовлетворява даден предикат и дали съществува поне един елемент от
; даден списък, който удовлетворява даден предикат.

(define (foldl combiner null-value l)
  (if (null? l)
      null-value
      (foldl combiner (combiner (car l) null-value) (cdr l))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (for-all? p? l)
  (foldl (lambda (x acc) (and (p? x) acc)) #t l))

(define (exists? p? l)
  (foldl (lambda (x acc) (or (p? x) acc)) #f l))

; Друг вариант да дефинираме exists?:
; използваме че ∃x∈l(p?(x)) <=> ¬∀x∈l(¬p?(x))
(define (exists? p? l)
  (not (for-all? (compose not p?) l)))

; Превеждаме ∀row∈m(∃x∈row(k | x)) на езика Scheme, използвайки for-all? и
; exists?
(define (check-matrix? m k)
  (define (divides? x)
    (zero? (remainder x k)))

  (for-all? (lambda (row) (exists? divides? row)) m))

(define check-matrix?-tests
  (test-suite
   "Tests for check-matrix?"

   (check-true (check-matrix? '((1 2 6) (3 8 9) (10 12 11)) 3))
   (check-false (check-matrix? '((1 2 4) (3 8 9) (10 12 11)) 3))))

(run-tests check-matrix?-tests)
