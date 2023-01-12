## Предварительные требования к окружению
- [GNU Bash](https://www.gnu.org/software/bash/)
- [GNU Make](https://www.gnu.org/software/make/)
- Компилятор C++, например [GCC](https://gcc.gnu.org/) или [Clang](https://clang.llvm.org/)
- [Verilator](https://verilator.org/), инструкция по установке [тут](https://verilator.org/guide/latest/install.html)
- [GTKWave](https://gtkwave.sourceforge.net/)

Для Windows рекомендуется пользоваться [MSYS2](https://www.msys2.org/) или [WSL](https://learn.microsoft.com/en-us/windows/wsl/install). Для macOS потребуется [Homebrew](https://brew.sh/).

## Make-файл

### Сборка конкретного модуля 

    $ make <имя модуля>

## Реализованные задачи
Усложнённые задачи 1:
 - Задача 2 (task_h1_2): [Модуль SystemVerilog](task_h1_2.v), [Тестбенч (С++)](task_h1_2.cpp)
 
 Задачи 2:
 - Задача 3 (xor4): [Модуль SystemVerilog](xor4.v)
 - Задача 4 (xor4): [Тестбенч (С++)](xor4.cpp)
 - Задача 5 (npriority): [Модуль SystemVerilog](npriority.v), [Тестбенч (C++)](npriority.cpp)
 
 Усложнённые задачи 2:
 - Задача 1 (mux8): [Модуль SystemVerilog](mux8.v), [Тестбенч (C++)](mux8.cpp)
 - Задача 2 (srff): [Модуль SystemVerilog](srff.v), [Тестбенч (C++)](srff.cpp)
 
Усложнённые задачи 3:
 - Задача 1 (alu32): [Модуль SystemVerilog](alu32.v), [Тестбенч (C++)](alu32.cpp)
 
 Контрольная:
 - Задача 2 (fsm2): [Модуль SystemVerilog](fsm2.v), [Тестбенч (C++)](fsm2.cpp)
 - Задача 3 (dc664): [Модуль SystemVerilog](dc664.v), [Тестбенч (C++), заглушка](dc664.cpp)
 - Задача 5 (cnt4): [Модуль SystemVerilog](cnt4.v), [Тестбенч (C++)](cnt4.cpp)
