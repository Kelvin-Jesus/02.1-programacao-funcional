#lang slideshow

(define (quadrado x) (* x x))
(define (soma-quadrados a b) (+ (quadrado a) (quadrado b)))
(define (f a) (soma-quadrados (+ a 1) (* a 2)))

(f 5)

(soma-quadrados (+ 5 1) (* 5 2))
(soma-quadrados 6 (* 5 2))
(soma-quadrados 6 10)
(+ (quadrado 6) (quadrado 10))
(+ (* 6 6) (quadrado 10))
(+ 36 (* 10 10))
(+ 36 100)
136