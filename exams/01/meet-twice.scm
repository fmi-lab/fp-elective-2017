(require rackunit rackunit/text-ui)

; Задача.
; Да се напише функция (meet-twice? f g a b), която проверява дали в
; целочисления интервал [a; b] съществуват две различни цели числа x и y
; такива, че f(x) = g(x) и f(y) = g(y).

(define (1+ x) (+ x 1))

; Итеративно решение на задачата:
; Дефинираме си помощна функция iter, която обхожда интервала [a; b], като на
; всяка стъпка следи текущия брой на пресичанията на f и g (count) и текущото
; начало на интевала (current-a). Имаме "благоприятна" база (count > 1): тогава
; можем директно да върнем #t. Имаме и "лоша" база (когато вече сме обходили
; целия интервал: current-a > b): тогава връщаме #f. Имаме "благоприятна"
; стъпка (когато f и g се пресичат в current-a): тогава увеличаваме count.
; Имаме и "лоша" стъпка (когато f и g не се пресичат в current-a): тогава count
; остава непроменен.
(define (meet-twice? f g a b)
  (define (meet-in? x)
    (= (f x) (g x)))

  (define (iter count current-a)
    (cond ((> count 1) #t)
          ((> current-a b) #f)
          ((meet-in? current-a)
           (iter (1+ count) (1+ current-a)))
          (else (iter count (1+ current-a)))))

  (iter 0 a))

; Ще разгледаме и друг начин да решим задачата, използвайки процедурата от
; по-висок ред accumulate.

(define (accumulate combiner null-value term a next b)
  (define (iter acc a)
    (if (> a b)
        acc
        (iter (combiner (term a) acc) (next a))))

  (iter null-value a))

; Идеята е да преброим колко пъти се пресичат функциите f и g. За целта
; използваме accumulate, като term функцията връща 1, ако f и g се пресичат
; в текущата точка (x), иначе 0. По този начин получаваме сума от нули и
; единици, където броя на единиците е точно броя на пресичанията на f и g.
; Накрая проверяваме дали намерения брой на пресичания (meetings-count) е
; поне 2.
(define (meet-twice? f g a b)
  (define (meet-in? x)
    (= (f x) (g x)))

  (define meetings-count
    (accumulate + 0 (lambda (x) (if (meet-in? x) 1 0)) a 1+ b))

  (> meetings-count 1))

(define (identity x) x)
(define (negate x) (- x))

(define meet-twice?-tests
  (test-suite
   "Tests for meet-twice?"

   (check-false (meet-twice? identity negate 0 0))
   (check-false (meet-twice? identity negate -3 1))
   (check-true (meet-twice? identity sqrt 0 5))))

(run-tests meet-twice?-tests)
