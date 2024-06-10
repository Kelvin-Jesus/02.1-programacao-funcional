#lang racket

; Defina a função e-logico que recebe os
; argumentos booleanos x e y e produz como
; resposta o e lógico entre eles, isto é:
; > (e-logico #f #f)
; #f
; > (e-logico #f #t)
; #f
; > (e-logico #t #f)
; #f
; > (e-logico #t #t)
; #t

(define (e-logico a b)
  (if (equal? a #t)
      (if (equal? b #t)
          #t
          #f)
      #f))

; versão simplificada
(define (e-logico-simplificado a b)
  (if a b #f))

(e-logico #f #f)
(e-logico-simplificado #f #f)