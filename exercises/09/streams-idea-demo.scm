(define (from n)
  (cons n (lambda () (from (+ n 1)))))

(define naturals (from 0))

(define (take n stream)
  (if (= n 0)
      '()
      (cons (car stream) (lambda () (take (- n 1) ((cdr stream)))))))

(define (collect-stream stream)
  (if (null? stream)
      '()
      (cons (car stream) (collect-stream ((cdr stream))))))

(collect-stream (take 10 naturals))
