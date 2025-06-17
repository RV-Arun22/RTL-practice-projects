`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Me
// Module Name: detector_fsm
// Project Name:  Moore 1101 overlapping sequence detector   
// Description: 5 state Moore FSM, would have taken less states if it was Mealy FSM
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module detector_fsm(
    input clk, rst,
    input k,        //input stream bit
    output z,
    output [2:0] state
    );
    
    parameter s0 = 'd0, s1 = 'd1, s2 = 'd2, s3 = 'd3, s4 = 'd4;
    reg [2:0] state, nxt;   //present & next state variables
    
    assign z = (state == s4)? 1:0;  //output depends on state only
    
    always @ (posedge clk)      //state updation sequential logic
        begin
            if (rst == 1'b1)
                state <= s0;
            else
                state <= nxt;
        end
    
    always @ (*)                //next state and output logic
        begin
            case(state)
                s0: begin
                        if (k == 1)
                            nxt = s1;
                        else    
                            nxt = s0;
                    end
                s1: begin
                        if (k==1)
                            nxt = s2;
                        else
                            nxt = s0;
                    end
                s2: begin
                        if (k==1)
                            nxt = s2;
                        else
                            nxt = s3;
                    end
                s3: begin
                        if (k==1)
                            nxt = s4;   //sequence found transition
                        else
                            nxt = s0;
                    end
                s4: begin
                        if (k==1)
                            nxt = s2;   //overlap transition
                        else
                            nxt = s0;
                    end
            endcase
        end
endmodule
