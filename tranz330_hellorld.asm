; Barebones program to write to the Tranz 330 VFD
;
; 2023 by Andrew Litt

            .ORG $0000
PIO_A_DAT   .EQU $00
PIO_A_CON   .EQU $01

STACK       .EQU $9000      ; seems like a decent place...

;--- Reset handler
RST:
    DI                      ;interrupts stay off
    LD      HL, STACK       ; set up stack though we don't use it
    LD      SP, HL

;--- Set up PIO_A to talk to the display
    LD      A, $CF          ; enter PIO_A bit mode (3)
    OUT     (PIO_A_CON), A  ; next byte must be I/O direction
    LD      A, $80          ; All outputs except bit 7
    OUT     (PIO_A_CON), A
    LD      A, $07          ; disable PIO interrupts
    OUT     (PIO_A_CON), A  ; next byte must be GPIO int mask
    LD      A, $FF          ; PIO int mask (redundant)
    OUT     (PIO_A_CON), A
    LD      A, $3F          ; initial GPIO port state
    OUT     (PIO_A_DAT), A

;--- Reset the display
    LD      A, $2F          ; assert display reset
    OUT     (PIO_A_DAT), A
    LD      B, $30          ; display reset hold time
VFD_RST_WAIT:
    DJNZ    VFD_RST_WAIT
    LD      A, $3F          ; deassert reset
    OUT     (PIO_A_DAT), A

;--- Send the payload
    LD      HL, PAYLOAD
STRING_SEND_LOOP:
    LD      A, (HL)         ; test if the current string char is zero
    OR      A
    JR      Z, INFINITY
    LD      C, A

    LD      B, $08          ; 8 bits to xfer, MSB first
BIT_SEND_LOOP:
    IN      A, (PIO_A_DAT)  ; get current port state
    AND     A, $9F          ; mask off the CLK and DAT bits
    RLC     C               ; rotate left w/ MSb into carry
    JR      NC, BIT_IS_ZERO ; if the MSb is zero, skip setting it
    OR      A, $20          ; MSb is one, set the DAT bit to match
BIT_IS_ZERO:
    OUT     (PIO_A_DAT), A  ; data setup with CLK low
    OR      A, $40          ; toggle CLK high
    OUT     (PIO_A_DAT), A
    AND     A, $BF          ; toggle CLK low
    OUT     (PIO_A_DAT), A
    DJNZ    BIT_SEND_LOOP   ; next bit

    INC     HL              ; next byte
    JP      STRING_SEND_LOOP

INFINITY:
    JP      INFINITY

;-- String to send
PAYLOAD:
    .BYTE   $FF             ; display to max brightness
    .BYTE   $AF             ; cursor to beginning of line
    ; null terminated string to print
    ; include spaces to cover all 16 characters on screen
    .BYTE "    HELLORLD    ",0

