(module stream racket
  (provide the-empty-stream cons-stream stream-car stream-cdr stream-null?)

  (define the-empty-stream '())

  (define-syntax cons-stream
    (syntax-rules ()
                  ((cons-stream h t) (cons h (delay t)))))

  (define stream-car car)

  (define (stream-cdr stream) (force (cdr stream)))

  (define stream-null? null?)

  (define-syntax delay
    (syntax-rules ()
                  ((delay x) (lambda () x))))

  (define (force delayed) (delayed)))
