.ORIG x3000

LD R0, inicio_izq
LD R1, contador
LD R2, color
LD R3, abajo

LOOP_IZQ
STR R2, R0, #0
STR R2, R0, #1
STR R2, R0, #2
STR R2, R0, #3
STR R2, R0, #4
STR R2, R0, #5

ADD R0, R0, R3
ADD R1, R1, #-1

BRp LOOP_IZQ

LD R1, contador_abj

LOOP_ABJ
STR R2, R0, #0

ADD R0, R0, #1
ADD R1, R1, #-1

BRp LOOP_ABJ

LD R0, inicio_der
LD R1, contador

LOOP_DER
STR R2, R0, #0
STR R2, R0, #-1
STR R2, R0, #-2
STR R2, R0, #-3
STR R2, R0, #-4
STR R2, R0, #-5

ADD R0, R0, R3
ADD R1, R1, #-1

BRp LOOP_DER

HALT

inicio_izq 	.FILL xC000
contador 	.FILL #118
color	 	.FILL x7FFF
abajo 		.FILL x80
contador_abj	.FILL #768
inicio_der	.FILL xC07F
