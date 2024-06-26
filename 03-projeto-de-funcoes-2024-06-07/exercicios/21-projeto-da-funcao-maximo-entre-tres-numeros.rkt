#lang racket

(require examples)

;; 21) Projete uma função que encontre o máximo entre
;; três números dados. Não use a função pré-definida max.
;;
;; Número Número Número -> Número
;;
;; Deve devolver o maior entre os valores x, y e z. Sem utilizar a função max

(examples
 (check-equal? (maximo 30 20 10) 30)
 (check-equal? (maximo 34 280 38) 280)
 (check-equal? (maximo 32 69 999) 999)
 (check-equal? (maximo 99 99 99) 99))

(define (maximo x y z)
  (cond
    [(and (>= x y) (>= x z)) x]
    [(>= y z) y]
    [else z]))


