#lang slideshow

; 01 Definitions
(define (square n)
  ; A semi-colon starts a line comment.
  ; The expression below is the function body.
  (filled-rectangle n n))

; 02 Local Bindings
; function inside a funtion to create local bindings.
(define (four circ)
  (define two-circs (hc-append circ circ))
  (vc-append two-circs two-circs))

(four (circle 10))

; using let it's possible to have multiple definitions
; that can be called in any expression position later on.
(define (checker piece1 piece2)
  (let ([piece12 (hc-append piece1 piece2)]
        [piece21 (hc-append piece2 piece1)])
    (vc-append piece12 piece21)))

(checker (colorize (square 10) "red")
         (colorize (square 10) "white"))

; the let itself dont allow for bindings to refer to each other
; let* is required to refer bindings created before
(define (checkerboard piece)
  (let* ([redPiece (colorize piece "red")]
         [whitePiece (colorize piece "black")]
         [newChecker (checker redPiece whitePiece)]
         [fourCheckers (four newChecker)])
    (four fourCheckers)))

(checkerboard (square 20))

; 03 Functions are Values
; Can define functions that accept functions as arguments
(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20)))

(colorize (series circle) "red")
(colorize (series square) "red")

; Lambda, is the same as an anonymous function
; you pass a new function as argument an that
; function don't have a name
(series (lambda (size) (checkerboard (square size))))

; 04 Lexical Scope
; Starts looking in the inner scope then looks outside
(define (rgb-series mk)
  (vc-append
   (series (lambda (sz) (colorize (mk sz) "red")))
   (series (lambda (sz) (colorize (mk sz) "green")))
   (series (lambda (sz) (colorize (mk sz) "blue")))))

(rgb-series circle)
(rgb-series square)

(define (rgb-maker mk)
  (lambda (sz)
    (vc-append (colorize (mk sz) "red")
               (colorize (mk sz) "green")
               (colorize (mk sz) "blue"))))

(series (rgb-maker circle))
(series (rgb-maker square))

; 05 - Lists
; Lists its an important part of Racket, since its inspired by Lisp
; List takes any number of arguments and returns a list with it
(list "red" "green" "blue")
(list (colorize (circle 10) "red") (colorize (square 10) "purple"))

(define (rainbow squareFunction)
  (map (lambda (color)
         (colorize squareFunction color))
       (list "red" "orange" "yellow" "green" "blue" "purple")))

(rainbow (square 10))

(apply vc-append (rainbow (square 10)))
