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

##Input and output signals
Input signals include:
1. 2 bit select signal
2. 1 bit clock signal
3. 1 bit reset signal
4. 8 bit input signal

Output signals include:
1. 8 

## Circuit Diagram of n-bit univversal shift register
![circuit diagram](https://media.geeksforgeeks.org/wp-content/uploads/USR12.png)

To clone the repository and download the netlist files for simulation, enter the following commands in your terminal:
`$ git clone https://github.com/rakshit-23/iiitb_usr`

`$ cd iiitb_usr/`

`$ iverilog iiitb_usr.v iiitb_usr_tb.v`

`$ ./a.out`

`$ gtkwave iiitb_usr_out.vcd`
