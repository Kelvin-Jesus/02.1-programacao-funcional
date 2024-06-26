#lang racket

(require examples)

;; 17) Escreva a especificação para a seguinte implementação de função.
;; Observe que a especificação sozinha deve ser suficiente para um
;; desenvolvedor fazer uma implementação.
;;
;; Número -> Número
;;
;; Retorna o valor total após o aumento com base no valor e na porcentagem

(examples
 (check-equal? (aumenta 1000.0 10.0) 1100.0)
 (check-equal? (aumenta 200.0 2.0) 204.0)
 (check-equal? (aumenta 0.0 0.0) 0.0)
 (check-equal? (aumenta 250.0 92.0) 480.0))

(define (aumenta valor porcentagem)
  (* valor (+ 1 (/ porcentagem 100))))

