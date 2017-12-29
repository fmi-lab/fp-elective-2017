(require rackunit rackunit/text-ui)

; Достатъчно е да намерим два реда, такива че
; максималният елемент в първия ред е по-малък от
; минималния елемент във втория ред.
; Можем да преведем условието така:
; ∃first-row∈matrix(∃second-row∈matrix((max first-row) < (min second-row)))
(define (two-rows? matrix)
  (define (exists? l p?)
    (foldl (lambda (x acc) (or (p? x) acc)) #f l))

  (define (rows-< first-row second-row)
    (< (apply max first-row) (apply min second-row)))

  (exists? matrix (lambda (first-row)
                    (exists? matrix (lambda (second-row)
                                      (rows-< first-row second-row))))))

; Друго решение, което следва същата идея като предното, но
; прави по-малко сравнения на редове.
(define (two-rows? matrix)
  (define (exist-two? matrix predicate)
    (define (next-row-iteration matrix)
      (and (not (null? matrix))
           (not (null? (cdr matrix)))
           (helper (car matrix) (cadr matrix) (cddr matrix) (cdr matrix))))

    (define (helper first-row second-row matrix-inner matrix)
      (or (predicate first-row second-row)
          (predicate second-row first-row)
          (or (and (not (null? matrix-inner))
                   (helper first-row
                           (car matrix-inner)
                           (cdr matrix-inner)
                           matrix))
              (and (null? matrix-inner)
                   (next-row-iteration matrix)))))

    (next-row-iteration matrix))

  (define (rows-< first-row second-row)
    (< (apply max first-row) (apply min second-row)))

  (exist-two? matrix rows-<))

(define two-rows?-tests
  (test-suite
   "Tests for two-rows?"

   (check-true (two-rows? '((1 2 3) (2 3 4) (3 4 5) (6 5 4))))
   (check-true (two-rows? '((2 3 4) (1 2 3) (3 4 5) (6 5 4))))
   (check-true (two-rows? '((2 3 4) (3 4 5) (1 2 3) (6 5 4))))
   (check-true (two-rows? '((2 3 4) (3 4 5) (6 5 4) (1 2 3))))
   (check-true (two-rows? '((6 5 4) (2 3 4) (3 4 5) (1 2 3))))
   (check-false (two-rows? '((6 5 4) (2 3 4) (3 4 5) (1 2 4))))))

(run-tests two-rows?-tests)
