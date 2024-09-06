.ORIG x3000

LD R0, inicio
LD R1, contador
LD R2, color
LD R3, abajo
LD R4, inicio
LD R5, contador_grone
LD R6, color_grone

LOOP

STR R2, R0, #0
STR R2, R0, #1
STR R2, R0, #2
STR R2, R0, #3
STR R2, R0, #4
STR R2, R0, #5

ADD R0, R0, R3
ADD R1, R1, #-1

BRp LOOP

LOOP_BORRA

STR R2, R0, #0
STR R2, R0, #1
STR R2, R0, #2
STR R2, R0, #3
STR R2, R0, #4
STR R2, R0, #5

STR R6, R4, #0
STR R6, R4, #1
STR R6, R4, #2
STR R6, R4, #3
STR R6, R4, #4
STR R6, R4, #5

ADD R0, R0, R3
ADD R4, R4, R3

LOOP_DELAY

ADD R2, R2, #-1

BRp LOOP_DELAY

LD R2, color

ADD R5, R5, #-1

BRp LOOP_BORRA

HALT

inicio		.FILL xC03B
contador	.FILL #6
color		.FILL x7C00
abajo		.FILL x80
color_grone	.FILL x0000
contador_grone	.FILL #112
