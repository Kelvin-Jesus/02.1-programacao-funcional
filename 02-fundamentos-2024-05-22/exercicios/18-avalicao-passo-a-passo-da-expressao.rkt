;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 18-avalicao-passo-a-passo-da-expressao) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#lang racket

; Qual o resultado da avaliação da expressão (* 3 (+ 1 2) (/ 10 2) 2)? Mostre o passo a passo da
; avaliação.
(* 3 (+ 1 2) (/ 10 2) 2)
(* 3 3 (/ 10 2) 2)
(* 3 3 (/ 10 2) 2)
(* 9 5 2)
90