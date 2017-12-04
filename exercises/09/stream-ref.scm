(require rackunit rackunit/text-ui "test-helpers.scm" "stream.scm")

(define s (list->stream '(1 2 3 4 5)))

(define stream-ref-tests
  (test-suite
   "Tests for stream-ref"

   (check = (stream-ref* s 0) 1)
   (check = (stream-ref* s 1) 2)
   (check = (stream-ref* s 2) 3)
   (check = (stream-ref* s 3) 4)
   (check = (stream-ref* s 4) 5)))

(run-tests stream-ref-tests)
