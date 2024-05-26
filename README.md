# **Verilog-Mini-Processor ES-204 Dgital Systems**
The efficiency of computers depends largely on their processors. A good processor can prevent crashes and ensure smooth gaming. To explore how they function, I have developed a mini-processor. The code and findings are available in this repository.

### **To Compile the Verilog Code using ```icarus-iverilog``` Compiler**
```bash
iverilog -o outputBinaryFile verilogModuleFile(s).v TestBenchFile.v
```

### **To Execute the Binary File**
```bash
vvp outputBinaryFile
```
## Overview

Real processors perform many operations, but our goal was to understand how a processor works, so we implemented only basic operations. This mini-processor includes various operations and their corresponding operation codes, as detailed in the table below. The first four bits of these codes designate the operation, while the last four bits identify the register (a memory unit) involved. Operations are executed using the accumulator, a key component of the processor. You can find more information about the accumulator [here](https://www.studysmarter.co.uk/explanations/computer-science/computer-organisation-and-architecture/accumulator/#:~:text=An%20accumulator%20functions%20as%20a,main%20memory%20or%20another%20register.).

```
1. PROGRAM MEMORY is a 16x8 array to represent
at max 16 instructions of 8 bits each

2. The Program Counter PC is a 4 bit register to store the
address of the current instruction being executed

3. The Instruction Register IR is an 8 bit register to store
the current instruction being executed

4. The Register File is a 16x8 array to store the values of
16 registers of 8 bits each

5. At each clock cycle, the instruction pointed by the PC is
fetched from the PROGRAM MEMORY and stored in IR and exexuted and 
the PC is incremented by 1

6. All ALU operations are performed on the ACC register

7. RSTN is the reset signal. When RSTN is low, the processor is reset

8. PAUSE is a control signal to pause the processor

```

### Instruction Fromat
#### Direct Instruction
| Operation Code | Register Address |
|---------------|---------------|

#### Branch Instruction
| Operation Code | 4 bit Address(label) |
|---------------|---------------|


### Instructions
| Instruction | Opcode | Operation          |
|-------------|--------|--------------------|
| 0000 0000   | NOP    | No operation       |                                                  
| 0001 xxxx   | ADD Ri | Add ACC with Register contents and store the result in ACC. Updates C/B | 
| 0010 xxxx   | SUB Ri | Subtract ACC with Register contents and store the result in ACC. Updates C/B | 
| 0011 xxxx   | MUL Ri | Multiply ACC with Register contents and store the result in ACC. Updates EXT | 
| 0100 xxxx   | DIV Ri | Divide ACC with Register contents and store the Quotient in ACC. Updates EXT with remainder. | 
| 0000 0001   | LSL ACC| Left shift left logical the contents of ACC. Does not update C/B | 
| 0000 0010   | LSR ACC| Left shift right logical the contents of ACC. Does not update C/B | 
| 0000 0011   | CIR ACC| Circuit right shift ACC contents. Does not update C/B | 
| 0000 0100   | CIL ACC| Circuit left shift ACC contents. Does not update C/B | 
| 0000 0101   | ASR ACC| Arithmetic Shift Right ACC contents | 
| 0101 xxxx   | AND Ri | AND ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated | 
| 0110 xxxx   | XRA Ri | XRA ACC with Register contents (bitwise) and store the result in ACC. C/B is not updated | 
| 0111 xxxx   | CMP Ri | CMP ACC with Register contents (ACC-Reg) and update C/B. If ACC>=Reg, C/B=0, else C/B=1 | 
| 0000 0110   | INC ACC| Increment ACC, updates C/B when overflows | 
| 0000 0117   | DEC ACC| Decrement ACC, updates C/B when underflows | 
| 1000 xxxx   | Br <4-bit address> | Update PC and branch to 4-bit address if C/B=1 | 
| 1001 xxxx   | MOV ACC, Ri | Move the contents of Ri to ACC | 
| 1010 xxxx   | MOV Ri, ACC | Move the contents of ACC to Ri | 
| 1011 xxxx   | Ret <4-bit address> | Update PC and return to the called program. | 
| 1111 1111   | HLT    | Stop the program (last instruction) | 


## Results
We have effectively implemented the instructions outlined above in our processor. The processor is capable of executing a single program, which must be defined within the Processor file before execution. This program can consist of any number of operations we wish to execute. We have also successfully implemented the processor on FPGA, a type of configurable integrated circuit. Refer to [link](https://en.wikipedia.org/wiki/Field-programmable_gate_array) to know more about FPGA's.

### A demo of implementation of the `mini-processor` on FPGA ---> [demo link](https://drive.google.com/file/d/1bZyZVlbj9aQSpFpS6jZFbf3M80JppOU-/view?usp=sharing)

