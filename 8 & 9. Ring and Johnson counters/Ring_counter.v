`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Me
// Module Name: Ring__counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Ring counter
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////


module Ring__counter # (parameter N = 8)(
    input clk, rst,
    output reg [(N-1):0] counter
    );
    
    always @ (posedge clk)
        begin
            if (rst == 1'b1)
                counter <= 'd1;
            else
                counter <= {counter[0],counter[(N-1):1]};   //last bit becomes 1st,
        end                                             //the remaing 3 shift right
endmodule
