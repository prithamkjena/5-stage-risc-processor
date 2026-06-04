# 5-Stage Pipelined RISC Processor

![5-Stage Pipelined RISC Processor](/assets/pipeline-proc.png)

This repository contains the design and Verilog implementation of a 5-stage pipelined RISC processor. The processor features hazard detection and a stall/forwarding unit to handle data hazards effectively.

This project was developed as part of the **CS F342 Computer Architecture** course at BITS Pilani, Hyderabad.

### Supported Instruction Set

The processor is capable of executing instructions such as `SUBI`, `LW`, `SW`, and `NAND`.

### Test Sequence

The following specific sequence of instructions was used as a test program to verify the processor's hazard detection and forwarding logic:

```assembly
SUBI  reg1, reg2, 15
LW    reg4, 0(reg1)
LW    reg5, 8(reg1)
NAND  reg6, reg8, reg5
SW    reg5, 0(reg7)
```

### Initial Register File State

The register file is initialized with the following values:
- `reg2` = `(25)₁₆`
- `reg8` = `(9878C)₁₆`
- `reg7` = `(C)₁₆`

## Project Structure

- `code/`: Contains the main Verilog modules for the processor (e.g., ALU, Control Unit, Forwarding Unit, Pipeline Registers).
- `testbench/`: Contains the testbench (`testbench.v`) for simulating the processor's execution.
- `report/`: Contains reports and documentation for the project.

### Key Components

- **Pipeline Stages**:
  - IF (Instruction Fetch)
  - ID (Instruction Decode)
  - EX (Execute)
  - MEM (Memory Access)
  - WB (Write Back)
- **Pipeline Registers**:
  - `IF/ID` (64 bits)
  - `ID/EX` (147 bits)
  - `EX/MEM` (72 bits)
  - `MEM/WB` (70 bits)
- **Hazard Handling**:
  - `Hazard Detection Unit`: Detects load-use hazards and issues stalls.
  - `Forwarding Unit`: Forwards data from EX/MEM or MEM/WB to the EX stage to avoid unnecessary stalls.
