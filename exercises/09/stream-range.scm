(require rackunit rackunit/text-ui "test-helpers.scm" "stream.scm")

(define stream-range-tests
  (test-suite
   "Tests for stream-range"

   (check-equal? (stream->list (stream-range 2 1)) '())
   (check-equal? (stream->list (stream-range 0 0)) '(0))
   (check-equal? (stream->list (stream-range 0 3)) '(0 1 2 3))
   (check-equal? (stream->list (stream-range 3 5)) '(3 4 5))
   (check-equal? (stream->list (stream-range 38 42)) '(38 39 40 41 42))))

(run-tests stream-range-tests)
