module iiitb_usr #(parameter MSB=8) ( data_in,data_out,clock,clear,select

    );
    input [MSB-1:0] data_in;
    output reg [MSB-1:0] data_out;
    input clear,clock;
    input [1:0] select;
    
    always@(posedge clock)
    begin
        if(clear==1'b1)
            data_out<={MSB{1'b0}};
        else
        begin 
            if(select==2'b00)
                data_out<={data_out[MSB-2:0],data_in[0]};
            else if(select==2'b01)
                data_out<={data_in[7],data_out[MSB-1:1]};
            else if(select==2'b10)
                data_out<=data_in;
            else
                data_out<=data_out;
         end
    end
    
endmodule

