cmake_minimum_required(VERSION 3.25)

# change to use the nesasm assembler
set(CMAKE_ASM_COMPILER ${CMAKE_CURRENT_SOURCE_DIR}/tools/nesasm-mac/build/nesasm)
# change to not link against any standard libraries
SET(CMAKE_ASM_STANDARD_LIBRARIES_INIT "")

project(game ASM)

add_executable(game-main)

target_sources(
    game-main
    PUBLIC
    src/main.asm
)

add_custom_target(emu fceux ${CMAKE_CURRENT_SOURCE_DIR}/src/main.nes)