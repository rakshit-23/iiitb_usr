# iiitb_usr- Universal Shift Register

## Description

The universal shift register features parallel load, left-shift and right-shift serial input, and synchronous active high reset. The registers have 4 modes of operation out of which 1 is operational according to the select lines. The 4 modes of operation are:
1. Shift left
2. Shift right
3. Parallel load
4. Temporary storage

Parallel synchronous loading is accomplished by applying the four bits of data and taking S0 low and S1 high. The data is loaded into the associated flip-flops and appears at the outputs after the positive transition of the clock input. 
Shift right is accomplished synchronously with the rising edge of the clock pulse when S0 is high and S1 is low. Serial data for this mode is entered at the shift-right data input. 
When both S0 and S1 are low, data shifts left synchronously and new data is entered at the shift-left serial inputs. 
When both S0 and S1 are high, the data inside the bidirectional shift  register does not change. 
Synchronous active high clear signal is used to reset the bidirectional shift register. 

## Input and output signals
Input signals include:
1. 2 bit select signal
2. 1 bit clock signal
3. 1 bit reset signal
4. 1 bit shift left serial signal
5. 1 bit shift right serial signal
6. 8 bit input signal

Output signals include:
1. 8 bit output signal

## Circuit Diagram of n-bit universal shift register
![download](https://user-images.githubusercontent.com/110079890/181252796-ff3f8513-397c-4ede-be52-f3030a6f2c22.png)

## Simulation waveform of the design
![simulation](https://user-images.githubusercontent.com/110079890/181254322-da4f5702-8428-44ac-814a-b53fe5a81f4f.png)

## Steps to install iverilog and GTKwave

### About iverilog
Icarus Verilog is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the `vvp` command. For synthesis, the compiler generates netlists in the desired format.

### About GTKWave
GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

### Installing iverilog and GTKWave in ubuntu
Open your terminal and type the following to install iverilog and GTKWave

`$   sudo apt get update`

`$   sudo apt get install iverilog gtkwave`

## Steps for cloning the repository ubuntu
To clone the repository and download the netlist files for simulation, enter the following commands in your terminal:


`$ sudo apt install git`

`$ git clone https://github.com/rakshit-23/iiitb_usr`

`$ cd iiitb_usr/`

`$ iverilog iiitb_usr.v iiitb_usr_tb.v`

`$ ./a.out`

`$ gtkwave iiitb_usr_out.vcd`

## Authour
- Rakshit Bhatia

## Acknowledgements
- Kunal Ghosh

