`timescale 1ns / 1ps

module iiitb_usr_tb;
    reg [7:0] data_in;
    wire [7:0] data_out;
    reg clear,clock,sl_ser,sr_ser;
    reg [1:0] select;
    
    iiitb_usr usr(data_in,data_out,clock,clear,select,sl_ser,sr_ser);
    
    initial
    begin
        $dumpfile("iiitb_usr_out.vcd");
        $dumpvars(0,iiitb_usr_tb);
        $monitor($time," clear=%b, select=%b , data_in=%b , data_out=%b \n",clear,select,data_in,data_out);
        clock=0;
        clear=1;    //clear
        data_in=8'b10101011;
        sl_ser=1'b1;
        sr_ser=1'b1;
        select=2'b01;   //right shift
        #6
        clear=0;
        #30 select=2'b00;   //left shift
        #30 select=2'b10;   //load input
        #30 select=2'b11;   //do nothing
            data_in=8'b11110000;
        #20 clear=1;    //reset
        #20 clear=0;
            select=2'b10;  //load input
    end
    
    always
        #5 clock=!clock;
        
endmodule

