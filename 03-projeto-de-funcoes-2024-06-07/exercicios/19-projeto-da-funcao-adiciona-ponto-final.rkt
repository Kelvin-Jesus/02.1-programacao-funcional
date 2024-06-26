#lang racket

(require examples)

;; 19) Projete uma função que adicione um ponto final a uma frase
;; se ela não acabar com um.
;;
;; String frase -> String
;;
;; Adiciona ponto final a uma frase caso não tenha.
;; Produz a frase com um ponto final caso não termine com ponto final.
;; Caso contrário, devolve a mesma frase

(examples
 (check-equal? (adiciona-ponto-final "Vai Corinthians.") "Vai Corinthians.")
 (check-equal? (adiciona-ponto-final "Vai Corinthians") "Vai Corinthians.")
 (check-equal? (adiciona-ponto-final ".") ".")
 (check-equal? (adiciona-ponto-final "") "."))

(define (adiciona-ponto-final frase)
  (define tamanho-frase (string-length frase))
  (cond
    [(equal? tamanho-frase 0) (string-append frase ".")]
    [(equal? (substring frase (sub1 tamanho-frase)) ".") frase]
    [else (string-append frase ".")]))


