#lang slideshow

;; Escreva uma expressão usando a linguagem slideshow
;; para gerar uma imagem com três círculos, um ao lado do
;; outro, e com o círculo do meio tendo o dobro de tamanho
;; dos outros dois.

(hc-append
 (colorize (circle 20) "blue")
 (colorize (circle 40) "purple")
 (colorize (circle 20) "blue"))