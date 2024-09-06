.ORIG x3000

; Inicialización
        LD R0, SQUARE_X     ; Posición X inicial del cuadrado
        LD R1, SQUARE_Y     ; Posición Y inicial del cuadrado
        LD R2, SQUARE_SIZE  ; Tamaño del cuadrado

MAIN_LOOP
        JSR DRAW_SQUARE
        JSR CHECK_INPUT
        JSR DELAY
        BRnzp MAIN_LOOP

DRAW_SQUARE
        LD R3, DISPLAY_ADDR
        ADD R3, R3, R0      ; Añadir offset X
        LD R4, SCREEN_WIDTH
        AND R5, R1, R1      ; Copiar R1 a R5
CALC_Y_OFFSET
        BRz CALC_Y_DONE     ; Si R5 es 0, terminamos
        ADD R3, R3, R4      ; Añadir ancho de pantalla a R3
        ADD R5, R5, #-1     ; Decrementar R5
        BRnzp CALC_Y_OFFSET
CALC_Y_DONE
        LD R4, SQUARE_COLOR
        STR R4, R3, #0      ; Dibujar pixel
        RET

CHECK_INPUT
        LDI R3, KBSR
        BRzp CHECK_INPUT_END
        LDI R3, KBDR
        LD R4, LEFT_KEY
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R3, R4
        BRz MOVE_LEFT
        LD R4, RIGHT_KEY
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R3, R4
        BRz MOVE_RIGHT
CHECK_INPUT_END
        RET

MOVE_LEFT
        ADD R0, R0, #-1
        BRzp MOVE_LEFT_END
        AND R0, R0, #0
MOVE_LEFT_END
        RET

MOVE_RIGHT
        ADD R0, R0, #1
        LD R3, MAX_X
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R0, R3
        BRn MOVE_RIGHT_END
        LD R0, MAX_X
MOVE_RIGHT_END
        RET

DELAY
        LD R3, DELAY_COUNT
DELAY_LOOP
        ADD R3, R3, #-1
        BRp DELAY_LOOP
        RET

; Datos
SQUARE_X     .FILL #62
SQUARE_Y     .FILL #62
SQUARE_SIZE  .FILL #5
SQUARE_COLOR .FILL xFFFF
DELAY_COUNT  .FILL #5000
LEFT_KEY     .FILL x61      ; 'a' en ASCII
RIGHT_KEY    .FILL x64      ; 'd' en ASCII
DISPLAY_ADDR .FILL xC000
SCREEN_WIDTH .FILL #128
MAX_X        .FILL #127
KBSR         .FILL xFE00
KBDR         .FILL xFE02

.END
