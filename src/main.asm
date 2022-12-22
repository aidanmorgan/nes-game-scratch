  .inesprg 1    ; Defines the number of 16kb PRG banks
  .ineschr 1    ; Defines the number of 8kb CHR banks
  .inesmap 0    ; Defines the NES mapper
  .inesmir 1    ; Defines VRAM mirroring of banks

  .rsset $0000

; bank 0 contains all of our game code - 8kB max.
  .bank 0
  .org $C000


RESET:
  

InfiniteLoop:
  JMP InfiniteLoop


; Called on every frame render - non maskable interrupt
; NTSC is called at 60Hz, PAL at 50Hz
NMI:

  RTI



  .bank 1
  .org $FFFA
  .dw NMI
  .dw RESET
  .dw 0

; bank 2 stores all of our sprites etc, to be filled later
  .bank 2
  .org $0000
