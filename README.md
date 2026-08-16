# Verilog 8-Bit Bubble Sort Processor

A simple 8-bit processor implemented in Verilog for executing bubble sort and other sorting algorithms.

## Overview

This project implements a complete digital processor in Verilog with:
- **Control Unit**: instruction decoding and execution
- **ALU**: arithmetic and logical operations
- **Register Bank**: 4 registers of 8-bits
- **Instruction Memory**: program storage
- **Data Memory**: algorithm data storage
- **Program Counter**: execution flow control

## Architecture

### Instruction Set

| Opcode | Name | Operation |
|--------|------|-----------|
| `000` | STORE | `mem[R1] = R2` |
| `001` | LOAD | `R2 = mem[R1]` |
| `010` | LOADI | `R1 = immediate` |
| `011` | JUMP | Conditional branch |
| `100` | INC/DEC | `R1 = R1 ± immediate` |
| `101` | CMP | Compare and set flag |
| `110` | MOV | `R1 = R2` |
| `111` | HALT | End program |

## Project Structure

```
rtl/                     # Hardware modules
├── processador.v       # Main processor
├── controle.v          # Control unit
├── ULA.v               # ALU
├── bancoDeRegs.v       # Register bank
├── memInst.v           # Instruction memory
├── memDados.v          # Data memory
├── PC.v                # Program counter
└── ...
tb/                     # Test benches
├── processadorBubbleSortTB.v
└── ...
build/                  # Build outputs
├── vvp/                # Compiled executables
└── vcd/                # Simulation waveforms
Makefile                # Build automation
```

## Getting Started

### Requirements
- `iverilog` (Verilog compiler)
- `vvp` (Verilog simulator)

### Installation
```bash
sudo apt-get install iverilog
```

### Running Tests

Simulate bubble sort:
```bash
make bubble
```

Test control unit:
```bash
make controle
```

Run all tests:
```bash
make all
```

Clean build:
```bash
make clean
```

## Viewing Simulations

Wave files are saved in `build/vcd/`. View with GTKWave:
```bash
gtkwave build/vcd/processadorBubbleSortTB.vcd
```

## Technical Specs

- **Word Size**: 8-bit
- **Registers**: 4 (R0-R3)
- **Architecture**: Von Neumann
- **Clock Cycle**: Fetch → Decode → Execute

## License

Educational use only.
