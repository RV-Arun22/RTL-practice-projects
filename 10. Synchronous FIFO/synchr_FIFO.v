`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Me
// 
// Create Date: 15.06.2025 20:51:32
// Design Name: 
// Module Name: synchr_FIFO
// Project Name: Synchronous FIFO
// Target Devices: Zynq 7000
// Tool Versions: 
// Description: Synchronous FIFO - Same read and write clock edges
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 3 always blocks used; since read & write can occur at the same clock edge
//                      and thus their processes need to trigger at posedge itself.
//                      They have no priority (independent of each other) and are not modelled using 'if-else' 
//                      in a single always block. Since read and write both have control over the 'count' variable,
//                      'count' updation also uses a separate always block.
//////////////////////////////////////////////////////////////////////////////////

module synchr_FIFO#(parameter width = 8, depth = 8)(
    input clk, rst,
    input [(width-1):0] data_in,
    input wen, ren,                 //write and read enable signals
    output reg [(width-1):0] data_out,
    output full, empty
    );
    
    reg [(width-1):0] fifo [(depth-1):0];
    reg [2:0] wptr, rptr;                   //write and read pointers for a FIFO of depth 8
    integer count;
    
    assign full = (count == depth);
    assign empty = (count == 0);
    
    always @ (posedge clk)
        begin
            if (rst ==1'b1)
                begin
                    wptr <= 'b0;
                    rptr <= 'b0;
                    count <= 0;
                end
            else
                begin
                    case ({wen, ren})
                        2'b01: begin
                                   if(!empty)
                                       begin
                                           data_out <= fifo[rptr];
                                           rptr <= rptr + 1'b1;        
                                           count <= count - 1;
                                       end
                               end 
                        2'b10: begin
                                   if(!full)
                                       begin
                                           fifo[wptr] <= data_in;
                                           wptr <= wptr + 1'b1;
                                           count <= count + 1;
                                       end
                               end
                        2'b11: begin
                                   fifo[wptr] <= data_in;
                                   wptr <= wptr + 1'b1;
                                   data_out <= fifo[rptr];
                                   rptr <= rptr + 1'b1;
                                   count <= count;  
                               end
                        2'b00: count <= count;
                    endcase    
                end
        end
endmodule
