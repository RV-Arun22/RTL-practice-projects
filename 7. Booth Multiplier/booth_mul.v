`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Arun
// 
// Create Date: 21.03.2025 13:16:26
// Design Name: 16-bit Booth Multiplier
// Module Name: booth_mul
// Project Name: Booth multiplier
// Target Devices: Zynq 7000
// Tool Versions: 
// Description: FSM implementation of booth multiplier for 
//              multiplication two signed N-bit (parameter N) numbers.
// 
// Register names: 
//      acc = accumulator, Q = multiplier, M = Multiplicand
//      Product = M x Q
// State naming convention:
//      S0: Idle/reset state & Initialaize registers when rst is deasserted
//      S1: Check count & lower 2 bits and perform 
//          required operation (Mux - Case statement)
//      S2: Perform required shifts and update iteration count
//      S3:
//      S4:
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Previously had 'product' as reg type, due to which it was in the 
//                      always block. Removed it and made it combinational due to 1 clk cycle extra 
//                      clock cycle delay.
//////////////////////////////////////////////////////////////////////////////////


    module booth_mul #(parameter N = 5)(
    input signed [(N-1):0] a,b,            //performing a * b
    input clk, rst,                 //using rst as start signal, deasserted rst means mul can start
    output signed [(2*N)-1:0] product,
    output [1:0] state
    );
    parameter S0 = 'd0, S1 = 'd1, S2 = 'd2, S3 = 'd3;
    reg [1:0] state;        //4 state controller variable
    reg signed [(N-1):0] acc;      //Partial product sum accumulator
    reg [N:0] Q;            //Multiplier, Q[0] is considered the extra last bit
    reg signed [(N-1):0] M;        //Multiplicand
    integer i;              //Iteration Count variable
    
    assign product = (state == S3)?{acc, Q[N:1]}:(1'b0);
    
    always @ (posedge clk)
        begin
            if (rst == 1'b1) begin
                state <= S0;
                //product <= 'b0;
                Q[0] <= 'b0;
                acc <= 'b0;
                i <= 0;
                end
            else 
                begin
                    case(state)
                        S0: begin
                                //product <= 'b0;
                                M <= a;
                                Q[N:1] <= b;
                                Q[0] <= 'b0;
                                acc <= 'b0;
                                i <= 0;
                                state <= S1;
                            end
                        S1: begin 
                                //product <= 'b0;
                                if (i < N)
                                    begin
                                        case(Q[1:0])
                                            2'b01: acc <= acc + M;
                                            2'b10: acc <= acc - M;
                                            default: acc <= acc;
                                        endcase
                                        state <= S2;
                                    end
                                else state <= S3;
                            end
                        S2: begin
                                //product <= 'b0;
                                Q <= {acc[0], Q[N:1]};
                                acc <= (acc>>>1);
                                i <= i + 1;
                                state <= S1;    //check counter variable again
                            end
                        S3: begin
                                //product <= {acc, Q[N:1]};
                                $display("Multiplication complete!");
                            end
                        default: begin 
                                    state <= S0;
                                    //product <= 'b0;
                                 end                                
                    endcase        
                end 
        end 
           
endmodule
