#lang racket

; Defina a função ou-logico que recebe os
; argumentos booleanos x e y e produz como
; resposta o ou lógico entre eles, isto é
; > (ou-logico #f #f)
; #f
; > (ou-logico #f #t)
; #t
; > (ou-logico #t #f)
; #t
; > (ou-logico #t #t)
; #t

(define (ou-logico a b)
  (if a #t b))

(ou-logico #f #f)

(ou-logico #f #t)

(ou-logico #t #f)

(ou-logico #t #t)