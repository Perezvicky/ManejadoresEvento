;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ejercicio5-final) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;Ejercicio 5

;definiremos algunas constantes
(define ALTO 500)
(define ANCHO 500)
(define RADIO 30)
(define DELTA 3)


;definimos el estado inicial

(define INICIO (make-posn (/ ANCHO 2) (/ ALTO 2)))


;dibujar corresponde a la cláusula to-draw
;dibujar: Estado -> Imagen
;dado un estado, devuelve una imagen

(define (dibujar e) (place-image (circle RADIO "solid" "blue") (posn-x e) (posn-y e) (empty-scene ANCHO ALTO )))

;teclado corresponde a la clásula on-key
;teclado: estado string -> estado
;Al presionar la "flecha hacia arriba" o "flecha hacia abajo" del teclado estas modificaran el estado

(define (teclado e s) (cond [(and (>= (posn-y e) RADIO) (key=? s "up")) (make-posn (posn-x e) (- (posn-y e) DELTA))]
                            [(and (<= (posn-y e) (- ALTO RADIO)) (key=? s "down")) (make-posn (posn-x e) (+ (posn-y e) DELTA))]
                            [(and (>= (posn-x e) RADIO) (key=? s "left")) (make-posn (- (posn-x e) DELTA) (posn-y e))]
                            [(and (<= (posn-x e) (- ANCHO RADIO)) (key=? s "right")) (make-posn (+ (posn-x e) DELTA) (posn-y e))]
                            [(key=? s " ") INICIO]
                            [else e]))


(define (mouse-handler n x y event) (cond [(string=? event "button-down") (make-posn x y)]
                                          [else n]))


(big-bang INICIO
                 [to-draw dibujar]
                 [on-key teclado]
                 [on-mouse mouse-handler])
