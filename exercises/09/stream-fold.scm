(require rackunit rackunit/text-ui "test-helpers.scm" "stream.scm")

(define s (list->stream '(1 2 3 4 5)))

(define stream-fold-tests
  (test-suite
   "Tests for stream-fold"

   (check-equal? (stream-fold s 0 +) 15)
   (check-equal? (stream-fold s 1 *) 120)  
   (check-equal? (stream-fold s '() (lambda (acc x) (cons x acc)))
                 '(5 4 3 2 1))))

(run-tests stream-fold-tests)
