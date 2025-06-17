`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Me
// 
// Create Date: 02/06/2025 01:19:42 PM
// Design Name: Barrel shifter
// Module Name: shifter
// Project Name: Barrel shifter
// Target Devices: Zynq 7000
// Tool Versions: 
// Description: 32-bit Barrel shifter (pure Mux based logic)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////


module shifter_tb();

    reg [31:0] a;
    reg [4:0] b;
    reg [1:0] c;
    wire [31:0] z;
    integer i;                      //type control variable
    
    shifter S1 (a, b, c, z);
    
    initial
        begin
            a = 32'd0; b = 5'd0; c = 2'b11; i = 0;
            #2 a = 32'hffff_ffff; b = 5'd31; 
            while (i < 4)
                begin
                    #2 i = i+1;
                       c = i;
                end
            #2 a = 32'h1000_0000; i = 0;
            while (i < 4)
                begin
                    #2 i = i+1;
                       c = i;
                end
            #1 $finish;
        end
        
endmodule
