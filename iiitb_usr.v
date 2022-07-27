module iiitb_usr  (data_in,data_out,clock,clear,select,sl_ser,sr_ser

    );
    input [7:0] data_in;
    output reg [7:0] data_out;
    input clear,clock,sl_ser,sr_ser;
    input [1:0] select;
    
    always@(posedge clock)
    begin
        if(clear==1'b1)
            data_out<=8'b00000000;
        else
        begin 
            if(select==2'b00)   //Shift left
                data_out<={data_out[6:0],sl_ser};
            else if(select==2'b01)  //Shift right
                data_out<={sr_ser,data_out[7:1]}; 
            else if(select==2'b10)  // Parallel load
                data_out<=data_in;
            else
                data_out<=data_out; //Temporary storage
         end
    end
    
endmodule

