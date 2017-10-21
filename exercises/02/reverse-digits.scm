(require rackunit rackunit/text-ui)

; Докато изчерпваме цифрите от number, ги слагаме в reversed
(define (reverse-digits n)
  (define (helper number reversed)
    (if (= number 0)   ; Изчерпали сме напълно number
        reversed       ; Съответно reversed e напълнен и готов
        (helper (quotient number 10)
                (+ (* reversed 10)
                   (remainder number 10)))))
  (helper n 0))

(define reverse-digits-tests
  (test-suite
   "Tests for reverse-digits"

   (check = (reverse-digits 3) 3)
   (check = (reverse-digits 12) 21)
   (check = (reverse-digits 42) 24)
   (check = (reverse-digits 666) 666)
   (check = (reverse-digits 1337) 7331)
   (check = (reverse-digits 65510) 1556)
   (check = (reverse-digits 1234567) 7654321)
   (check = (reverse-digits 8833443388) 8833443388)
   (check = (reverse-digits 100000000000) 1)))

(run-tests reverse-digits-tests)
