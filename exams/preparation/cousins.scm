; В дадено двоично дърво казваме, че два възела са “братовчеди”,
; ако най-близкият общ родител на двамата е поне две нива над тях.
; Да се напише функция cousins, която по дадено двоично дърво от
; различни числа и възел u в него намира броя на всички братовчеди на u.
; Представянето на дървото е по ваш избор.


(require rackunit rackunit/text-ui)

(define the-empty-tree '())
(define (make-tree root left right) (list root left right))
(define (make-leaf root) (list root the-empty-tree the-empty-tree))

(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define (cousins u t)
  (define (member-tree? u t)
    (and (not (empty-tree? t))
         (or (= u (root-tree t))
             (member-tree? u (left-tree t))
             (member-tree? u (right-tree t)))))

  (define (count-nodes t)
    (if (empty-tree? t)
        0
        (+ 1
           (count-nodes (left-tree t))
           (count-nodes (right-tree t)))))

  (define (successors t)
    (if (empty-tree? t)
        0
        (+ (count-nodes (left-tree t))
           (count-nodes (right-tree t)))))

  (cond ((or (empty-tree? t)
             (and (not (empty-tree? (left-tree t)))
                  (= u (root-tree (left-tree t))))
             (and (not (empty-tree? (right-tree t)))
                  (= u (root-tree (right-tree t)))))
         0)
        ((member-tree? u (left-tree t)) (+ (cousins u (left-tree t))
                                           (successors (right-tree t))))
        ((member-tree? u (right-tree t)) (+ (cousins u (right-tree t))
                                            (successors (left-tree t))))
        (else 0)))

(define tree
  (make-tree 1
             (make-tree 2
                        (make-tree 4
                                   (make-tree 8
                                              (make-leaf 14)
                                              (make-leaf 15))
                                   (make-tree 9
                                              the-empty-tree
                                              (make-leaf 16)))
                        (make-tree 5
                                   (make-leaf 10)
                                   (make-leaf 11)))
             (make-tree 3
                        (make-leaf 6)
                        (make-tree 7
                                   (make-tree 12
                                              (make-leaf 17)
                                              the-empty-tree)
                                   (make-tree 13
                                              (make-leaf 18)
                                              (make-leaf 19))))))

(define cousins-tests
  (test-suite
   "Tests for cousins"
   
   (check = (cousins 1 tree) 0)
   (check = (cousins 2 tree) 0)
   (check = (cousins 3 tree) 0)
   (check = (cousins 4 tree) 7)
   (check = (cousins 5 tree) 7)
   (check = (cousins 6 tree) 9)
   (check = (cousins 7 tree) 9)
   (check = (cousins 8 tree) 9)
   (check = (cousins 9 tree) 9)
   (check = (cousins 10 tree) 12)
   (check = (cousins 11 tree) 12)
   (check = (cousins 12 tree) 9)
   (check = (cousins 13 tree) 9)
   (check = (cousins 14 tree) 10)
   (check = (cousins 15 tree) 10)
   (check = (cousins 16 tree) 11)
   (check = (cousins 17 tree) 11)
   (check = (cousins 18 tree) 10)
   (check = (cousins 19 tree) 10)
   (check = (cousins 20 tree) 0)))

(run-tests cousins-tests)
