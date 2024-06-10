#lang racket

(define (sinal x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [else -1]))

(sinal 1)
(cond
  [(> 1 0) 1]
  [(= 1 0) 0]
  [else -1])

(cond
  [#t 1]
  [(= 1 0) 0]
  [else -1])

(cond
  [#t 1]
  [else -1])