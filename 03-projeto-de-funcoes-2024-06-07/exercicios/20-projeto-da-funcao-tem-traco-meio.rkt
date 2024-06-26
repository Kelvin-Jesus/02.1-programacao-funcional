#lang racket

(require examples)

;; 20) Projete uma função que determine se uma palavra tem um traço ("-")
;; no meio, como por exemplo, "lero-lero". Não use nenhuma
;; condicional na implementação.
;;
;; String palavra -> Boolean
;;
;; Produz #t se a palavra contém um "-" exatamente no meio.
;; Caso contrário, produz #f

(examples
 (check-equal? (tem-traco-meio? "lero-lero") #t)
 (check-equal? (tem-traco-meio? "tem-traco") #f)
 (check-equal? (tem-traco-meio? "-") #t)
 (check-equal? (tem-traco-meio? "") #f))

(define (tem-traco-meio? palavra)
  (define tamanho-palavra (string-length palavra))
  (define meio (quotient tamanho-palavra 2))
  (and (odd? tamanho-palavra)
       (equal? (substring palavra meio (add1 meio)) "-")))


