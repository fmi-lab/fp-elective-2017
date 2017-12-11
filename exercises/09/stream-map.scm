(require rackunit rackunit/text-ui "test-helpers.scm" "stream.scm")

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define s (list->stream '(1 2 3 4 5)))

(define stream-map-tests
  (test-suite
   "Tests for stream-map"

   (check-equal? (stream->list (stream-map* the-empty-stream identity)) '())
   (check-equal? (stream->list (stream-map* s identity)) '(1 2 3 4 5))
   (check-equal? (stream->list (stream-map* s 1+)) '(2 3 4 5 6))
   (check-equal? (stream->list (stream-map* s square)) '(1 4 9 16 25))))

(run-tests stream-map-tests)
