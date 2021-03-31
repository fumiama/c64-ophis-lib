.include "Ophis-2.1/platform/c64_0.oph"
.include "Ophis-2.1/platform/c64kernal.oph"
.outfile "clock.prg"

.data zp
.space _na 1	; a的临时存放处
.space _nx 1	; x的临时存放处
.space _ny 1	; y的临时存放处

.text
*   jsr rdtim
    stx _nx
    sty _ny
    jsr printbyte
    jsr printspace
    lda _nx
    jsr printbyte
    jsr printspace
    lda _ny
    jsr printbyte
    lda #13     ; 换行
    jsr chrout
    jmp -       ; 死循环

printbyte:
    sta _na
    txa
    pha
    ldx #8	; 打印8bit
*   lda #$30	; a = '0'
    asl _na	; 左移一位，溢出到c
    adc #0	; a = a + c + 0
    jsr chrout	; putchar(a)
    dex		; x--
    bne -	; if(x != 0) goto 上个星号
    pla
    tax
    rts

printspace:
    lda #$20
    jsr chrout
    rts

.checkpc $A000
.data
.checkpc $D000