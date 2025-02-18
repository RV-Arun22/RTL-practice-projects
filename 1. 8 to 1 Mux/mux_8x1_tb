`timescale 1ns/1ps

module mux_8x1_tb ();

wire y;
reg [7:0] ip;
reg [2:0] sel;
integer i;
mux_8x1 mux1 (ip, sel, y); 

initial 
    begin
        ip = 8'b10101010; sel = 3'd0;
        for (i = 0; i < 8; i = i+1)
            begin
                #2 sel = i;
            end  
        #50 $finish;  
    end
endmodule
