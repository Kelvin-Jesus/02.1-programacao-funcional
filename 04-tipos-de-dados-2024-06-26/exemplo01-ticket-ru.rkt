#lang racket

(require examples)

;; TipoUsuario InteiroPositivo -> NúmeroPositivo
;; Determina o custo de *quant* tíquetes para um usuário do tipo *tu*.
;; O custo de um tíquete é
;; - "aluno" 5,0
;; - "servidor<=3" 5,0
;; - "servidor>3" 10,0
;; - "docente" 10,0
;; - "externo" 19,0

(examples
  (check-equal? (custo-tiquetes "aluno" 3) 15.0)       ; (* 3 5.0)
  (check-equal? (custo-tiquetes "servidor<=3" 2) 10.0) ; (* 2 5.0)
  (check-equal? (custo-tiquetes "servidor>3" 2) 20.0)  ; (* 2 10.0)
  (check-equal? (custo-tiquetes "externo" 4) 76.0))    ; (* 4 19.0)

(define (custo-tiquetes tipo-usuario quant)
  (cond
    [(or (equal? tipo-usuario "aluno") 
         (equal? tipo-usuario "servidor<=3")) 
     (* quant 5.0)]
    [(or (equal? tipo-usuario "servidor>3") 
         (equal? tipo-usuario "docente")) 
     (* quant 10.0)]
    [else (equal? tipo-usuario "externo") (* quant 19.0)]))
