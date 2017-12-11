(module test-helpers racket
  (require "stream.scm")

  (provide stream->list list->stream)

  (define (stream->list s)
    (if (stream-null? s)
        '()
        (cons (stream-car s)
              (stream->list (stream-cdr s)))))

  (define (list->stream l)
    (if (null? l)
        the-empty-stream
        (cons-stream (car l)
                     (list->stream (cdr l))))))
