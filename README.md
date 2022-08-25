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

## RTL simulation waveform of the design
![simulation](https://user-images.githubusercontent.com/110079890/181254322-da4f5702-8428-44ac-814a-b53fe5a81f4f.png)

## Steps to install iverilog, GTKwave and Yosys

### About iverilog
Icarus Verilog is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the `vvp` command. For synthesis, the compiler generates netlists in the desired format.

### About GTKWave
GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

### About Yosys
Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. Selected features and typical applications:

- Process almost any synthesizable Verilog-2005 design
- Built-in formal methods for checking properties and equivalence
- Mapping to ASIC standard cell libraries (in Liberty File Format)
- Mapping to Xilinx 7-Series and Lattice iCE40 and ECP5 FPGAs

### Installing iverilog and GTKWave in ubuntu
Open your terminal and type the following to install iverilog and GTKWave

`$   sudo apt get update`

`$   sudo apt get install iverilog gtkwave`


## Yosys commands for gate level synthesis using SKY130 process node and PDK
```
read_verilog iiitb_usr.v
synth -top iiitb_usr
dfflibmap -liberty /home/rakshit/iiitb_usr/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/rakshit/iiitb_usr/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_usr_synth.v
stat 
```
## Physical Cells used from the target architecture
![stat](https://user-images.githubusercontent.com/110079890/184287089-1c3d1a84-779a-4789-841e-7c4f77607469.png)

 - a31oi: 3-input AND into first input of 2-input NOR.

   Y = !((A1 & A2 & A3) | B1)
 - dfxtp: Delay flop, single output.
 - nand2: 2-input NAND.
 - nand3b: 3-input NAND, first input inverted.
 - nor2: 2-input NOR.
 - o21ai: 2-input OR into first input of 2-input NAND.
 
   Y = !((A1 | A2) & B1)
 - o21bai: 2-input OR into first input of 2-input NAND, 2nd input inverted.
   
   Y = !((A1 | A2) & !B1_N)

## Synthesized netlist of the RTL design
![synthesized_netlist](https://user-images.githubusercontent.com/110079890/184321918-dce53f88-f723-49f5-b684-2208f6b71f65.png)


## Gate level simulation waveform of the design
![GLS](https://user-images.githubusercontent.com/110079890/184289638-2aac193f-77d4-476b-9a7e-1472b15da076.png)

The gate level simulation waveform matches with the RTL simulation waveform.



## Steps for cloning the repository ubuntu
To clone the repository and download the netlist files for simulation, enter the following commands in your terminal:


`$ sudo apt install git`

`$ git clone https://github.com/rakshit-23/iiitb_usr`

`$ cd iiitb_usr/`

`$ iverilog iiitb_usr.v iiitb_usr_tb.v`

`$ ./a.out`

`$ gtkwave iiitb_usr_out.vcd`

## Authour
- Rakshit Bhatia, M.Tech student at IIIT Bangalore.

## Acknowledgements
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact information
- Rakshit Bhatia- rakshit2325@gmail.com
- Kunal Ghosh-  kunalghosh@gmail.com

