#lang racket

(require examples)

;; 15) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.
;;
;; inteiropositivo -> boolean
;;
;; produz #t se uma pessoa com a idade n é supercentenária,
;; isto é, tem 110 anos ou mais, #f caso contrário.
(examples
 (check-equal? (supercentenario 101) #f)
 (check-equal? (supercentenario 110) #t)
 (check-equal? (supercentenario 112) #t))

(define (supercentenario n)
  (or (>= n 110)))

