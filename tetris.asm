.ORIG x3000
; Inicialización
LD R1, INIT_COL
LD R2, INIT_ROW

MAIN_LOOP
    JSR ERASE_PIECE
    JSR CHECK_INPUT
    JSR MOVE_DOWN
    JSR CHECK_COLLISION
    BRz PLACE_PIECE
    JSR DRAW_PIECE
    JSR DELAY
    BRnzp MAIN_LOOP

PLACE_PIECE
    ADD R2, R2, #-1  ; Retroceder una fila para colocar la pieza
    JSR DRAW_PIECE
    JSR RESET_POSITION
    BRnzp MAIN_LOOP

CHECK_INPUT
    LDI R0, KBSR
    BRzp CHECK_INPUT_END
    LDI R0, KBDR
    LD R3, LEFT_ARROW
    ADD R3, R0, R3
    BRz MOVE_LEFT
    LD R3, RIGHT_ARROW
    ADD R3, R0, R3
    BRz MOVE_RIGHT
CHECK_INPUT_END
    RET

MOVE_LEFT
    ADD R1, R1, #-1
    JSR CHECK_COLLH
    BRz UNDO_MOVE_LEFT
    RET
UNDO_MOVE_LEFT
    ADD R1, R1, #1
    RET

MOVE_RIGHT
    ADD R1, R1, #1
    JSR CHECK_COLLH
    BRz UNDO_MOVE_RIGHT
    RET
UNDO_MOVE_RIGHT
    ADD R1, R1, #-1
    RET

CHECK_COLLH
    ; Verificar límites horizontales
    AND R0, R1, R1
    BRn COLLISION_H  ; Si R1 < 0, colisión izquierda
    LD R3, SCREEN_WIDTH
    NOT R3, R3
    ADD R3, R3, #1
    ADD R3, R1, R3
    BRzp COLLISION_H  ; Si R1 >= SCREEN_WIDTH, colisión derecha
    AND R0, R0, #0
    ADD R0, R0, #1  ; No hay colisión
    RET
COLLISION_H
    AND R0, R0, #0  ; Colisión detectada
    RET

DRAW_PIECE
    ST R7, SAVE_R7
    ST R1, SAVE_R1
    ST R2, SAVE_R2
    JSR FIRST_PIXEL
    LEA R0, Sn_PieceSprite
    LDR R4, R0, #0 ; Ancho de la pieza
    LDR R5, R0, #1 ; Alto de la pieza
    LEA R6, Sn_Pixels
    ADD R6, R6, #-1
DRAW_LOOP
    ADD R6, R6, #1
    LDR R0, R6, #0
    BRz SKIP_PIXEL
    STR R0, R3, #0
SKIP_PIXEL
    ADD R3, R3, #1
    ADD R4, R4, #-1
    BRp DRAW_LOOP
    LEA R0, Sn_PieceSprite
    LDR R4, R0, #0
    LD R0, ROW
    ADD R3, R3, R0
    NOT R0, R4
    ADD R0, R0, #1
    ADD R3, R3, R0
    ADD R5, R5, #-1
    BRp DRAW_LOOP
    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R7, SAVE_R7
    RET

ERASE_PIECE
    ST R7, SAVE_R7
    ST R1, SAVE_R1
    ST R2, SAVE_R2
    JSR FIRST_PIXEL
    LEA R0, Sn_PieceSprite
    LDR R4, R0, #0
    LDR R5, R0, #1
    AND R0, R0, #0
ERASE_LOOP
    STR R0, R3, #0
    ADD R3, R3, #1
    ADD R4, R4, #-1
    BRp ERASE_LOOP
    LEA R0, Sn_PieceSprite
    LDR R4, R0, #0
    LD R6, ROW
    ADD R3, R3, R6
    NOT R6, R4
    ADD R6, R6, #1
    ADD R3, R3, R6
    ADD R5, R5, #-1
    BRp ERASE_LOOP
    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R7, SAVE_R7
    RET

FIRST_PIXEL
    LD R3, PANTALLA
    LD R6, ROW
    ADD R3, R3, R1  ; Ajustar posición horizontal
    AND R0, R2, R2
    BRz END_FIRST_PIXEL
FIRST_PIXEL_LOOP
    ADD R3, R3, R6  ; Ajustar posición vertical
    ADD R0, R0, #-1
    BRp FIRST_PIXEL_LOOP
END_FIRST_PIXEL
    RET

MOVE_DOWN
    ADD R2, R2, #1  ; Incrementa la posición vertical
    RET

CHECK_COLLISION
    LD R0, SCREEN_HEIGHT
    NOT R0, R0
    ADD R0, R0, #1
    ADD R0, R2, R0
    BRzp COLLISION
    AND R0, R0, #0
    ADD R0, R0, #1  ; No hay colisión
    RET
COLLISION
    AND R0, R0, #0  ; Colisión detectada
    RET

RESET_POSITION
    LD R1, INIT_COL
    LD R2, INIT_ROW
    RET

DELAY
    LD R5, DELAY_COUNT
DELAY_LOOP
    ADD R5, R5, #-1
    BRp DELAY_LOOP
    RET

PANTALLA .FILL xC000
ROW .FILL x0080
INIT_COL .FILL #40  ; Ajusta esto para la posición inicial horizontal
INIT_ROW .FILL #0
DELAY_COUNT .FILL x1FFF
SAVE_R7 .BLKW 1
SAVE_R1 .BLKW 1
SAVE_R2 .BLKW 1
SCREEN_HEIGHT .FILL #124  ; Ajusta esto según la altura real de tu pantalla
SCREEN_WIDTH .FILL #128   ; Ajusta esto según el ancho real de tu pantalla
KBSR .FILL xFE00
KBDR .FILL xFE02
LEFT_ARROW .FILL #-97   ; ASCII 'a'
RIGHT_ARROW .FILL #-100  ; ASCII 'd'

Sn_PieceSprite .FILL 9 ; Ancho de la pieza
.FILL 6 ; Alto de la pieza

Sn_Pixels
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL xF000
.FILL xF000
.FILL xF000
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL xF000
.FILL xF000
.FILL xF000
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL xF000
.FILL xF000
.FILL xF000
.FILL xF000
.FILL xF000
.FILL xF000
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL xF000
.FILL xF000
.FILL xF000
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL xF000
.FILL xF000
.FILL xF000
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.FILL x5FFF
.END