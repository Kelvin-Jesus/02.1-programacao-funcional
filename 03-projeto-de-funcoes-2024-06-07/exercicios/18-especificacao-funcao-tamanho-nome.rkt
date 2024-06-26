#lang racket

(require examples)

;; 18) Escreva a especificação para a seguinte implementação de função. Observe
;; que a especificação sozinha deve ser suficiente para um programador
;; fazer uma implementação.
;;
;; String -> String
;;
;; Tamanhos
;; - "curto"
;; - "médio"
;; - "longo"
;;
;; Deve informar o tamanho do nome.
;; Se a quantidade de caracteres do nome for menor ou igual a 4, produz "curto".
;; Caso seja menor ou igual a 10, produz "médio".
;; Caso contrário, produz "longo".

(examples
 (check-equal? (tamanho-nome "Ana") "curto")
 (check-equal? (tamanho-nome "Ruan") "curto")
 (check-equal? (tamanho-nome "Maria") "médio")
 (check-equal? (tamanho-nome "Nickolasen") "médio")
 (check-equal? (tamanho-nome "Constantine") "longo")
 (check-equal?
  (tamanho-nome "Taumatawhakatangihangakoauauotamateaturipukakapikimaungahoronukupokaiwhenuakitanatahu")
  "longo"))

(define (tamanho-nome nome)
  (cond
    [(<= (string-length nome) 4) "curto"]
    [(<= (string-length nome) 10) "médio"]
    [else "longo"]))

