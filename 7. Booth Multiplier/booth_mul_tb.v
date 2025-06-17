`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2025 13:16:26
// Design Name: 
// Module Name: booth_mul_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Tested for 5-bit multiplication to keep iteration count small
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module booth_mul_tb #(parameter n = 5)();
    reg [(n-1):0] a,b;              //performing a * b
    reg  clk, rst;                 //using rst as start signal, deasserted rst means mul can start
    wire [(2*n)-1:0] product;
    wire [1:0] state;
    
    booth_mul multiplier (a,b,clk,rst,product,state);
    
    always #5 clk = ~clk;
    
    initial
        begin
            clk = 1'b0; rst = 1'b1; a = 'b01110; b = 'b11011;
            #22 rst = 1'b0;
            #300 $finish;
        end
    
endmodule
