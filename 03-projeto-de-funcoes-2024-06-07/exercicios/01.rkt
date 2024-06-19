#lang racket

(require examples)

;; 13)
;;
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

;; 14)
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

;; 15)
;; InteiroPositivo -> Boolean
;;
;; Produz #t se uma pessoa com a idade n é supercentenária,
;; isto é, tem 110 anos ou mais, #f caso contrário.
(examples
 (check-equal? (supercentenario 101) #f)
 (check-equal? (supercentenario 110) #t)
 (check-equal? (supercentenario 112) #t))

(define (supercentenario n)
  (or (>= n 110)))

;; 16)
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

;; 22) Projete uma função que receba como parâmetro uma string e
;; um número natural n e substitua os primeiros n caracteres
;; da string por n letras x.

;; 23) Faça a execução passo a passo de algumas funções definidas nos
;; exercícios. Para isto você deve criar um novo arquivo,
;; mudar a linguagem para “Beginning Student” e copiar o código da função e da
;; chamada exemplo da função.

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

;(define (sem-espacos-extras? texto)
;  (define tamanho (string-length texto))
;  (define ultima-pos (sub1 tamanho))
;  (define inicio (if (equal? tamanho 0)
;                     ""
;                     (substring texto 0 1)))
;  (define fim (if (equal? tamanho 0)
;                  ""
;                  (substring texto ultima-pos (add1 ultima-pos))))
;  (and (not (equal? inicio " "))
;      (not (equal? fim " "))))