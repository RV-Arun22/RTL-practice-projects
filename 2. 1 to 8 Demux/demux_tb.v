`timescale 1ns / 1ps
module demux_1x8_tb();

wire [7:0] y;
reg en, ip;
reg [2:0] sel;
integer i;
  
demux_1x8 demux1 (ip, sel, en, y);

initial 
    begin
        ip = 1; sel = 3'd0; en = 1'b1;
        #10 en = 1'b0;
        for (i = 0; i < 8; i = i+1)
            begin
                #2 sel = i; //ip = ~ip;
            end  
        #20 $finish;  
    end

endmodule
