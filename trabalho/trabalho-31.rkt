#lang racket

(require examples)

(struct registro (tipo quantidade) #:transparent)
;; Representa um registro da tabela
;;
;; tipo String - Tipo do registro
;; quantidade Número Inteiro - ocorrências do tipo dentro da tabela

;; lista-de-string lista
;;
;; Se a lista-de-string não for vazia, devolve uma lista de registro apartir de uma lista de string
;; no formato "tipo quantidade", com cada registro representando uma linha da tabela.
;; Caso contrário, devolve empty.

(examples
 (check-equal? (gera-tabela empty) empty)
 (check-equal? (gera-tabela (list "banana 40" "uva 60")) (list (registro "banana" 40) (registro "uva" 60)))
 (check-equal? (gera-tabela (list "uva 60" "banana 40")) (list (registro "uva" 60) (registro "banana" 40))))

(define (gera-tabela lista-de-string)
  (cond
    [(empty? lista-de-string) empty]
    [else (cons (string->registro (first lista-de-string))
                (gera-tabela (rest lista-de-string)))]))

;; linha string - representa uma linha na tabela
;;
;; Produz uma string vazia caso a linha seja vazia, caso contrário,
;; produz um novo registro com o tipo e a quantidade.

(examples
 (check-equal? (string->registro "") "")
 (check-equal? (string->registro "Uva 60") (registro "Uva" 60)))

(define (string->registro linha)
  (define linha-tipo-quantidade (string-split linha " "))
  (cond
    [(empty? linha-tipo-quantidade) ""]
    [else (registro (first linha-tipo-quantidade)
               (string->number (first (rest linha-tipo-quantidade))))]))

;; lista-de-registros - lista com os registros da tabela
;;
;; Devolve uma lista contendo a quantidade dos registros
(examples
 (check-equal? (lista-de-quantidades empty) empty)
 (check-equal? (lista-de-quantidades (list (registro "uva" 60) (registro "banana" 40))) (list 60 40)))
(define (lista-de-quantidades lista-de-registros)
  (cond
    [(empty? lista-de-registros) empty]
    [else (cons (registro-quantidade (first lista-de-registros))
                (lista-de-quantidades (rest lista-de-registros)))]))

;; lista-de-quantidades - lista de inteiros
;;
;; Devolve o maior inteiro dada uma lista de quantidades
(examples
 (check-equal? (maximo empty) empty)
 (check-equal? (maximo (list 0 0 0)) 0)
 (check-equal? (maximo (list 60 40)) 60)
 (check-equal? (maximo (list 40 60)) 60)
 (check-equal? (maximo (list 60 40 100)) 100))
(define (maximo lista-de-quantidades)
  (cond
    [(empty? lista-de-quantidades) empty]
    [(empty? (rest lista-de-quantidades)) (first lista-de-quantidades)]
    [else (max (first lista-de-quantidades)
               (maximo (rest lista-de-quantidades)))]))

;;
;;
;; Devolve o registro com o tipo que contém a maior quantidade de caracteres
(examples
  (check-equal? (tipo-com-mais-caracteres empty) empty)
  (check-equal? (tipo-com-mais-caracteres (list (registro "Morango" 120))) (registro "Morango" 120))
  (check-equal? (tipo-com-mais-caracteres (list (registro "Laranja" 40) (registro "Chocolate" 25))) (registro "Chocolate" 25)))
(define (tipo-com-mais-caracteres lista-de-registros)
  (cond
    [(empty? lista-de-registros) empty]
    [(empty? (rest lista-de-registros)) (first lista-de-registros)]
    [else (if (>= (string-length (registro-tipo (first lista-de-registros)))
                  (string-length (registro-tipo (tipo-com-mais-caracteres (rest lista-de-registros)))))
                (first lista-de-registros)
                (tipo-com-mais-caracteres (rest lista-de-registros)))]))

;; Análise:
;; A partir de uma lista de registros, deve somar a quatidade total de vendas.
;;
;; Lista lista-de-registros -> Inteiro
;;
;; Produz a soma total de vendas de cada registro na lista-de-registros

(examples 
  (check-equal? (somar-quantidades empty) 0)
  (check-equal? (somar-quantidades (list 
                                     (registro "Baunilha" 150) 
                                     (registro "Flocos" 60) 
                                     (registro "Morango" 40))) 250))

(define (somar-quantidades lista-de-registros)
  (cond
    [(empty? lista-de-registros) 0]
    [else (+ (registro-quantidade (first lista-de-registros))
             (somar-quantidades (rest lista-de-registros)))]))

;; Análise: 
;; A partir da lista de quantidades e da quantidade total de vendas, calcular porcentagem
;; a porcentagem que cada tipo representa do total de vendas
;; 
;; Lista lista -> lista-de-quantidades
;;
;; Produz uma nova lista com as porcentagens que cada registro representa em relação ao total de vendas
;; usando a fórmula (quantidade-vendas-do-tipo/vendas-totais) * 100.

(examples 
  (check-equal? (porcentagens (list 200 300 500) 1000) (list 20 30 50)))
(define (porcentagens lista total-de-vendas) 
  (cond
    [(or (empty? lista) (= total-de-vendas 0)) empty]
    [else (append (list (calcula-porcentagem (first lista) total-de-vendas))
                (porcentagens (rest lista) total-de-vendas))]))

(examples 
  (check-equal? (calcula-porcentagem 200 1000) 20)
  (check-equal? (calcula-porcentagem 300 1000) 30)
  (check-equal? (calcula-porcentagem 500 1000) 50))

(define (calcula-porcentagem quantidade-venda total-de-vendas)
  (* (/ quantidade-venda total-de-vendas) 100))

(examples 
  (check-equal? (gerar-barras (list)) empty)
  (check-equal? (gerar-barras (list 10 20 30)) (list "[=]" "[==]" "[===]")))
(define (gerar-barras lista)
  (cond
    [(empty? lista) empty]
    [else (append (list (gerar-barra (first lista))) (gerar-barras (rest lista)))]))

(examples
  (check-equal? (gerar-barra 0) "[]")
  (check-equal? (gerar-barra 20) "[==]")
  (check-equal? (gerar-barra 100) "[==========]"))
(define (gerar-barra porcentagem)
  (cond
    [(= porcentagem 0) "[]"]
    [else (string-append "[" (gerar-tracos (total-barras porcentagem)) "]")]))

(examples 
  (check-equal? (total-barras 0) 0)
  (check-equal? (total-barras 20) 2))
(define (total-barras porcentagem)
  (round (quotient porcentagem 10)))

(examples 
  (check-equal? (gerar-tracos 0) "")
  (check-equal? (gerar-tracos 2) "=="))
(define (gerar-tracos quantidade)
  (cond
    [(<= quantidade 0) ""]
    [else (string-append "=" (gerar-tracos (sub1 quantidade)))]))


(define (concatena-tipo-barras-porcentagem tipos barras porcentagens)
  (cond 
    [(or (empty? tipos) (empty? barras) (empty? porcentagens)) empty]
    [else (cons (string-append (first tipos) " " (first barras) " " (string-append (number->string (first porcentagens)) "%"))
                (concatena-tipo-barras-porcentagem (rest tipos) (rest barras) (rest porcentagens)))]))

(define (lista-de-tipo tabela)
  (cond
    [(empty? tabela) empty]
    [else (cons (registro-tipo (first tabela))
                (lista-de-tipo (rest tabela)))]))

(define (gera-grafico tabela)
  ;; (define maximo-da-lista (maximo (lista-de-quantidades tabela)))
  ;; (define tamanho-maior-tipo (string-length (registro-tipo (tipo-com-mais-caracteres tabela))))
  (define lista-de-tipos (lista-de-tipo tabela))
  (define total-de-vendas (somar-quantidades tabela))
  (define porcentagem-de-cada-tipo (porcentagens (lista-de-quantidades tabela) total-de-vendas))
  (define barras (gerar-barras porcentagem-de-cada-tipo)) 
  (define lista-porcentagens (porcentagens (lista-de-quantidades tabela) total-de-vendas))
  (define lista-barras (concatena-tipo-barras-porcentagem lista-de-tipos barras lista-porcentagens))
  lista-barras)

(define (main)
  (define entrada (port->lines))
  (define tabela (gera-tabela entrada))
  (define saida (gera-grafico tabela))
  (display-lines saida))

(main)
