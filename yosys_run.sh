read_liberty -lib /home/rakshit/iiitb_usr/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog iiitb_usr.v
synth -top iiitb_usr
dfflibmap -liberty /home/rakshit/iiitb_usr/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/rakshit/iiitb_usr/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_usr_synth.v
stat 
show
