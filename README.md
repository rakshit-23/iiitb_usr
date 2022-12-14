# iiitb_usr- Universal Shift Register

## 1. Description

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

## 2. Input and output signals
Input signals include:
1. 2 bit select signal
2. 1 bit clock signal
3. 1 bit reset signal
4. 1 bit shift left serial signal
5. 1 bit shift right serial signal
6. 8 bit input signal

Output signals include:
1. 8 bit output signal

## 3. Circuit Diagram of n-bit universal shift register
<p align="center">
  <img width="1000" height="500" src="https://user-images.githubusercontent.com/110079890/181252796-ff3f8513-397c-4ede-be52-f3030a6f2c22.png">
</p>


## 4. RTL simulation waveform of the design
<p align="center">
  <img width="1500" height="300" src="https://user-images.githubusercontent.com/110079890/186836636-899a7104-62f5-4afb-9980-5eefb45903ab.png">
</p>

## 5. Steps to install iverilog, GTKwave and Yosys

### 5.1 About iverilog
Icarus Verilog is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the `vvp` command. For synthesis, the compiler generates netlists in the desired format.

### 5.2 About GTKWave
GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

### 5.3 About Yosys
Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. Selected features and typical applications:

- Process almost any synthesizable Verilog-2005 design
- Built-in formal methods for checking properties and equivalence
- Mapping to ASIC standard cell libraries (in Liberty File Format)
- Mapping to Xilinx 7-Series and Lattice iCE40 and ECP5 FPGAs

### 5.4 Installing iverilog and GTKWave in ubuntu
Open your terminal and type the following to install iverilog and GTKWave

```
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```


## 6. Yosys commands for gate level synthesis using SKY130 process node and PDK
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
### 6.1 Physical Cells used from the target architecture
<p align="center">
  <img width="500" height="500" src="https://user-images.githubusercontent.com/110079890/184287089-1c3d1a84-779a-4789-841e-7c4f77607469.png">
</p>

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

##  7. Synthesized netlist of the RTL design
<p align="center">
  <img width="1000" height="1000" src="https://user-images.githubusercontent.com/110079890/184321918-dce53f88-f723-49f5-b684-2208f6b71f65.png">
</p>



## 8. Gate level simulation waveform of the design
<p align="center">
  <img width="2000" height="250" src="https://user-images.githubusercontent.com/110079890/186837236-1ebdda62-128c-443c-b684-5d41efd41e4b.png">
</p>


The gate level simulation waveform matches with the RTL simulation waveform.

## 9. Steps to install OpenLane
### 9.1 Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

### 9.2 Installation instructions 
```
$   apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

Now clone the OpenLane git repository: 
```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane/
$   sudo make
$   sudo make test
```

### 9.3 Magic
Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.


In order to compile Magic on a vanilla installation of Ubuntu, the following additional packages are needed (at a minimum):

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
To install magic
```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic/
$   ./configure
$   sudo make
$   sudo make install
```
## 10. Extracting lef file from inverter layout
Our objective is to extract LEF from the given layout of inverter in standard format. To do so follow the following steps:
1. Clone the vsdstdcelldesign github using the following command

```
$   git clone https://github.com/nickson-jose/vsdstdcelldesign)
```

2. Copy the sky130A.tech from the folder /home/rakshit/OpenLane/pdks/sky130A/libs.tech/magic and paste it into the cloned directory.

3. Open the inverter magic layout using the command
``` 
$   magic -T sky130A.tech sky130_inv.mag
```
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187485641-e9eb45c9-6003-4e65-a6f4-eab80ab8712a.png">
</p>

4. For every layer of inverter which needs to be turned into a port, select that particular layer by pressing s key on keyboard and then select Edit >> Text.

5. Select the sticky checkbox in attach to layer option, uncheck default option and enter locali layer for input and output ports. Also select the enable checkbox and enter 0 and 1 as portnumber for input and output port respectively.

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187486062-c4c396d8-2d53-4012-ae61-45a2cbee895e.png">
</p>

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187491099-53dcbd1f-a389-425b-819a-25f7fdae4d0c.png">
</p>


6. For power and ground ports, enter metal1 layer and enter 0 and 3 as portnumber for power and ground ports respectively.

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187486485-1648a301-3a17-4c76-8767-bacbf829da79.png">
</p>

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187486477-d2f411e1-469c-4af8-bb80-0c7f08991b83.png">
</p>

7. Define the purpose of each port

Select port A in magic and write the following commands in tkcon:
```
port class input
port use signal
```
Select Y area in magic and write the following commands in tkcon:
```
port class output
port use signal
```
Select VPWR area in magic and write the following commands in tkcon:
```
port class inout
port use power
```

Select VGND area in magic and write the following commands in tkcon:
```
port class inout
port use ground
```

8. Generate the lef file by typing the following command in tkcon:
```
lef write
```
This generates sky130_vsdinv.lef file.

## 11. Running the design in OpenLane using interactive mode
To run the design in OpenLane:
1. Create a folder named iiitb_usr in designs folder of OpenLane.

2. Create a src folder inside the iiitb_usr folder.

3. Copy the verilog file (iiitb_usr.v) , extracted lef file of inverter (sky130_vsdinv) and the library files (sky130_fd_sc_hd__fast.lib, sky130_fd_sc_hd__slow.lib, sky130_fd_sc_hd__typical.lib) inside the folder 'OpenLane/designs/iiitb_usr/src'.

4. Then go to OpenLane folder and type the following commands to run OpenLane

```
$   sudo make mount
$   ./flow.tcl -interactive
%   prep -design iiitb_usr
%   set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
%   add_lefs -src $lefs
```
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187896319-eed1ff22-7adb-4f8f-adf9-20fdbf6e28bd.png">
</p>

5. To run synthesis, type the following command
```
%   run_synthesis
```
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187417258-0ecf2284-515e-492a-95c6-3ead84c01a5b.png">
</p>

  The synthesized netlist can be seen in the folder '/home/rakshit/OpenLane/designs/iiitb_usr/runs/RUN_2022.08.30_09.15.49/results/synthesis'

  The following cells were mapped from the library.

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187417863-d206d8f5-e0b2-4315-9b2f-3864bce3add7.png">
</p>

  The inverter `sky130_vsdinv` is present in the generated netlist.

6. To run the floorplan and the placement, type the following commands
```
%   run_floorplan
%   run_placement
```
<p align="center">
  <img  src="ttps://user-images.githubusercontent.com/110079890/187419699-6013b524-91fa-4498-a408-477eee1ea54a.png">
</p>

  To view the floorplan, type the following command in the folder    '/home/rakshit/OpenLane/designs/iiitb_usr/runs/RUN_2022.08.30_09.15.49/results/floorplan'
```
$   magic -T /home/rakshit/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_usr.def &
```

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187430936-69663863-457c-4f8f-aefc-8851d3613b0f.png">
</p>

  To view the placement, type the following command in the folder '/home/rakshit/OpenLane/designs/iiitb_usr/runs/RUN_2022.08.30_09.15.49/results/placement'

```
$   magic -T /home/rakshit/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_usr.def &
```
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187421437-15ffa5d4-8c68-43e6-bfe7-3b22f557882c.png">
</p>

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187421492-08e3efe3-cf50-40d0-aa92-35f1da903856.png">
</p>

7. To run the clock tree synthesis, type the following command
```
%   run_cts
```
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187421918-d8e3801c-c69c-4f44-b55f-0543de5afb1f.png">
</p>

  The netlist with clock buffers can be seen in the folder  '/home/rakshit/OpenLane/designs/iiitb_usr/runs/RUN_2022.08.30_09.15.49/results/cts'

8. To run the routing, type the following command
```
%   run_routing
```

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187423272-def469b9-10be-4d56-8020-612ef957acf0.png">
</p>

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/187423317-e6ad8e3b-78ee-4823-a9bb-40c5abb8f191.png">
</p>

## 12. Steps for cloning the repository in ubuntu
To clone the repository and download the netlist files for simulation, enter the following commands in your terminal:
```
$  sudo apt install git
$  git clone https://github.com/rakshit-23/iiitb_usr
$  cd iiitb_usr/
$  iverilog iiitb_usr.v iiitb_usr_tb.v
$  ./a.out
$  gtkwave iiitb_usr_out.vcd
```
## 13. RESULTS FOR MIDTERM EXAMINATIONS
### 13.1 Post-synthesis Gate count for the design
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/192626345-ac1a992d-a099-4d43-bfcf-7ed89b1aab4d.png">
</p>
The post-synthesis gate count for the design is 45 cells.


### 13.2 Area of the design using box command
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/192626695-503e09b9-4d90-40fb-9922-58edc787cef0.png">
</p>
The area of the design is 4408.716 micro meter sq.


### 13.3 Performance achieved for the design using OpenSTA
The netlist produced after the clock tree synthesis is taken into account to determine the chip's performance. The netlist contains 8 flip-flops. Using the OpenSTA tool, the slack for each register to register path is calculated and the path with worst slack is used to calculated the performance of the design.

To invoke OpenSTA type the following commands in the terminal opened in the OpenLANE directory
```
$ sudo make mount
  sta
```
Type the following commands to calculate the performance of the design in OpenSTA
```
read_liberty -min /home/rakshit/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v56.lib

read_liberty -max /home/rakshit/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v56.lib

read_verilog /home/rakshit/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/iiitb_usr.v

link_design iiitb_usr

read_sdc /home/rakshit/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/iiitb_usr.sdc

read_spef /home/rakshit/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/iiitb_usr.spef

create_clock -name clock -period 10 {clock}

set_propagated_clock clock

report_checks -from _71_ -to _70_
```
<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/192630532-ee61c8ad-0c58-4ae5-a192-da0c2ff4a36d.png">
</p>

The library setup time is 0.09 ns and the data arrival time (delay) is 1.58 ns. The minimum slack of the design for clock period of 10 ns is 8.56 ns.
Therefore the maximum clock frequency of the design is 1/(10-8.56)=694.44 MHz.

### 13.4 Flip-flop to Standard cell ratio

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/192632884-d1d33d24-7b20-4961-b3b4-cbfb523cbd93.png">
</p>

```
Flop ratio = Number of D Flip flops 
             ______________________
             Total Number of cells
```

Number of flip-flops in the design = 8

Number of cells in the design = 45

Flip-flop to Standard cell ratio = 8/45 = 0.1778 = 17.78%

### 13.5 Power Consumed

<p align="center">
  <img  src="https://user-images.githubusercontent.com/110079890/192633618-2ae30f6f-493e-43d8-94c9-aa60b64992b1.png">
</p>

The total power consumed by the design is 4.11 micro Watts
 - Internal Power = 2.31 micro Watt
 - Switching Power = 1.8 micro Watt
 - Leakage Power = 0.188 nano Watt


## Author
- Rakshit Bhatia, M.Tech student at IIIT Bangalore.

## Acknowledgements
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
- Madhav Rao, Associate Professor, IIIT Bangalore

## Contact information
- Rakshit Bhatia- rakshit2325@gmail.com
- Kunal Ghosh-  kunalghosh@gmail.com
- Madhav Rao- mr@iiitb.ac.in

## References
1. GeeksforGeeks, "Universal Shift Register" 
https://www.geeksforgeeks.org/universal-shift-register-in-digital-logic/#:~:text=A%20bidirectional%20shift%20register%20is,register%20with%20parallel%20load%20provision.&text=A%20n%2Dbit%20universal%20shift,n%204%C3%971%20multiplexers.

2. Yosys Open Synthesis Suite
https://yosyshq.net/yosys/  

3. SkyWater, "SKY130 PDK DOCUMENTATION" https://skywater-pdk.readthedocs.io/en/main/

4. Open Circuit Design, "Magic install" http://opencircuitdesign.com/magic/install.html

5. GTKWave http://gtkwave.sourceforge.net/

6. Icarus Verilog http://iverilog.icarus.com/ 

7. The OpenRoad Project, "OpenLane" https://github.com/The-OpenROAD-Project/OpenLane
