#lang racket

(require examples)

;; 12)
;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com idade id é isento da
;; tarifa de transporte público, isto é, tem
;; 18 anos ou menos ou 65 ou mais. Produz #f caso contrário.
(examples
 (check-equal? (isento-tarifa? 17) #t)
 (check-equal? (isento-tarifa? 18) #f)
 (check-equal? (isento-tarifa? 50) #f)
 (check-equal? (isento-tarifa? 65) #t)
 (check-equal? (isento-tarifa? 70) #t))

(define (isento-tarifa? id)
  (or (<= id 17) (>= id 65)))

;; 13)
;; Inteiro -> Inteiro
;;
;; Conta a quantidade de dígitos de n.
;; Se n é 0, então devolve zero.
;; Se n é menor que zero, então devolve a quantidade
;; de dígitos do valor absoluto de n.
(examples
 (check-equal? (quantidade-digitos 121) 3)
 (check-equal? (quantidade-digitos 0) 1)
 (check-equal? (quantidade-digitos -1519) 4))

(define (quantidade-digitos n)
  (string-length (number->string (abs n))))

;; 14)
;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com a idade n é supercentenária,
;; isto é, tem 110 anos ou mais, #f caso contrário.
(examples
 (check-equal? (supercentenario 101) #f)
 (check-equal? (supercentenario 110) #t)
 (check-equal? (supercentenario 112) #t))

(define (supercentenario n)
  (or (>= n 110) #f))

;; 15)
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

;; 16) Escreva a especificação para a seguinte implementação de função. 
;; Observe que a especificação sozinha deve ser suficiente para um 
;; desenvolvedor fazer uma implementação.
;;
;; Inteiro -> Float
;;
;; Retorna o valor total após o aumento com base no valor e na porcentagem

(examples
  (check-equal? (aumenta 1000 10) 1100)
  (check-equal? (aumenta 200 2) 204)
  (check-equal? (aumenta 0 0) 0)
  (check-equal? (aumenta 250 92))

(define (aumenta valor porcentagem)
    (* valor (+ 1 (/ porcentagem 100))))

;; 17) Escreva a especificação para a seguinte implementação de função. Observe 
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
  (check-equal? (tamanho-nome "Maria") "médio")
  (check-equal? (tamanho-nome "Ana") "curto")
  (check-equal? 
    (tamanho-nome "Taumatawhakatangihangakoauauotamateaturipukakapikimaungahoronukupokaiwhenuakitanatahu") 
    "longo"))

(define (tamanho-nome nome)
    (cond
        [(<= (string-length nome) 4) "curto"]
        [(<= (string-length nome) 10) "médio"]
        [else "longo"]))
