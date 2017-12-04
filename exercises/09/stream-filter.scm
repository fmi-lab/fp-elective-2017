(require rackunit rackunit/text-ui "test-helpers.scm" "stream.scm")

(define s (list->stream '(0 1 2 3 4 5)))

(define stream-filter-tests
  (test-suite
   "Tests for stream-filter"

   (check-equal? (stream->list (stream-filter* the-empty-stream even?)) '())
   (check-equal? (stream->list (stream-filter* s even?)) '(0 2 4))
   (check-equal? (stream->list (stream-filter* s odd?)) '(1 3 5))))

(run-tests stream-filter-tests)
