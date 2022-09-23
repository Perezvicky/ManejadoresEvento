;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ejercicio7-final) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;ejercicio 7

;definimos constantes

(define AUTO (rectangle 30 10 "solid" "green"))
(define ANCHO 1000)
(define ALTO 60)
(define DELTA 1)

;definimos una estructura del tipo auto

(define-struct auto [hpos vel])

;definimos el estado inicial

(define INICIO (make-auto (/ (image-width AUTO) 2) 0))

;dibujar responde a la clásula to-draw
;dibujar: estado -> image
;dado un estado lo imprime en la pantalla

(define (dibujar e) (place-image AUTO (auto-hpos e) (/ ALTO 2) (empty-scene ANCHO ALTO)))

;reloj responde a la clásula on-tick
;on-tick: estado -> estado
;cada un tick se sumará DELTA unidades al estado

(define (reloj e) (cond [(<= (auto-hpos e) (- ANCHO (image-width AUTO))) (make-auto (+ (auto-hpos e) DELTA (auto-vel e)) (auto-vel e))]
                        [else e]))


;mouse responde a la cláusula on-mouse
;mouse: estado number number string -> estado
;dado un evento el estado será la posición en x donde este evento se produjo.

(define (mouse e x y evento) (cond [(string=? evento "button-down") (make-auto x (auto-vel e))]
                                   [else e]))


;teclado responde a la clásula on-key
;teclado: estado string -> estado
;dado un evento el estado será DELTA unidades hacia la izquierda o derecha.

(define (teclado e s) (cond [(string=? s "left") (make-auto (- (auto-hpos e) DELTA) (auto-vel e))]
                            [(string=? s "right") (make-auto (+ (auto-hpos e) DELTA) (auto-vel e))]
                            [(string=? s "up") (make-auto (auto-hpos e) (+ (auto-vel e) 0.5))]
                            [(string=? s "down") (make-auto (auto-hpos e) (- (auto-vel e) 0.5))]
                            [(string=? s " ") INICIO]
                            [else e]))



(big-bang INICIO [to-draw dibujar]
                 [on-tick reloj]
                 [on-mouse mouse]
                 [on-key teclado])