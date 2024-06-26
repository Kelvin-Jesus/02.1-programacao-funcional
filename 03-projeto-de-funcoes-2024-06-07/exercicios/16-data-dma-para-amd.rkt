#lang racket

(require examples)

;; 16) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.
;;
;; String -> String
;;
;; Transforma a data de entrada do formato "dia/mes/ano"
;; para o formato "ano/mes/dia".
;;
;; Requer que o dia e o mês tenham dois dígitos e que
;; o ano tenha quatro dígitos.
(examples
 (check-equal? (data-dma->data-amd "19/07/2023") "2023/07/19")
 (check-equal? (data-dma->data-amd "01/01/1980") "1980/01/01")
 (check-equal? (data-dma->data-amd "02/02/2002") "2002/02/02"))

(define (data-dma->data-amd data)
  (define dia (substring data 0 2))
  (define mes (substring data 3 5))
  (define ano (substring data 6 10))
  (string-append ano "/" mes "/" dia))


