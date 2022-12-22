  .inesprg 1    ; Defines the number of 16kb PRG banks
  .ineschr 1    ; Defines the number of 8kb CHR banks
  .inesmap 0    ; Defines the NES mapper
  .inesmir 1    ; Defines VRAM mirroring of banks

  .rsset $0000

; will use these values as part of loading hte nametables for each of the spritesheets
pointerBackgroundLowByte  .rs 1
pointerBackgroundHighByte .rs 1


; bank 0 contains all of our game code - 8kB max.
  .bank 0
  .org $C000


RESET:
  JSR LoadBackground

InfiniteLoop:
  JMP InfiniteLoop


LoadBackground:

; put the value $2000 on the PPU (reset the PPU)
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006

  LDA #LOW(background)
  STA pointerBackgroundLowByte
  LDA #HIGH(background)
  STA pointerBackgroundHighByte

  LDX #$00
  LDY #$00

.Loop:
  LDA [pointerBackgroundLowByte], y
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INC pointerBackgroundHighByte
  INX
  CPX #$04
  BNE .Loop
  RTS


; Called on every frame render - non maskable interrupt
; NTSC is called at 60Hz, PAL at 50Hz
NMI:

  RTI



  .bank 1
  .org $E000

background:
  .include "graphics/background.asm"

  .org $FFFA
  .dw NMI
  .dw RESET
  .dw 0


; bank 2 stores all of our sprites etc, to be filled later
  .bank 2
  .org $0000
  .incbin "graphics.chr"

