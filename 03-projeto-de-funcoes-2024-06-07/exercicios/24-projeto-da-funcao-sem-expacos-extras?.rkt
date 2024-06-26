#lang racket

(require examples)

;; 24) Você está fazendo um programa e precisa verificar se um
;; texto digitado pelo usuário está de acordo com algumas regras.
;; A regra “sem espaços extras” requer que o texto não comece e
;; não termine com espaços. Projete uma função que verifique
;; se um texto qualquer está de acordo com a regra “sem
;; espaços extras”.

;; String texto -> Boolean
;;
;; Produz #t se o texto seguir a regra de não possuir espaço no início e no fim.
;; Caso contrário, devolve #f

(examples
 (check-equal? (sem-espacos-extras? "não tem") #t)
 (check-equal? (sem-espacos-extras? " tem ") #f)
 (check-equal? (sem-espacos-extras? " tem no início") #f)
 (check-equal? (sem-espacos-extras? "tem no fim ") #f)
 (check-equal? (sem-espacos-extras? "") #t)
 (check-equal? (sem-espacos-extras? " ") #f))

(define (sem-espacos-extras? texto)
  (define tamanho (string-length texto))
  (define ultima-pos (sub1 tamanho))
  (define inicio (if (equal? tamanho 0)
                     ""
                     (substring texto 0 1)))
  (define fim (if (equal? tamanho 0)
                  ""
                  (substring texto ultima-pos (add1 ultima-pos))))
  (and (not (equal? inicio " "))
      (not (equal? fim " "))))


