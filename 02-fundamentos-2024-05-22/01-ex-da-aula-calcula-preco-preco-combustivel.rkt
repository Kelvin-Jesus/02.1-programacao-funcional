#lang racket

; (distancia/rendimento) * preco-do-litro
(define (calcula-valor-combustivel distancia preco-do-litro rendimento)
  (* (/ distancia rendimento) preco-do-litro))

(calcula-valor-combustivel 400 5 10)