`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Me
// 
// Create Date: 02/06/2025 01:19:42 PM
// Design Name: Barrel shifter
// Module Name: shifter
// Project Name: Barrel shifter
// Target Devices: 
// Tool Versions: 
// Description: 32-bit Barrel shifter (pure Mux based logic)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: case statements within case modelling
// 
//////////////////////////////////////////////////////////////////////////////////


module shifter (a, b, c, z);
    input [31 : 0] a;		//32-bit operand
    input [4 : 0] b;		//5-bit shift amount
    input [1 : 0] c;		//shift type
    output reg [31 : 0] z;  //final shifted output register
    
    reg [31 : 0]  z4, z3, z2, z1;	//intermediate results of cascaded shift stages 
    reg [1 : 0] sel4, sel3, sel2, sel1, sel0;	//mux controls for the 5-stages of muxes
    
always @ (a, b, c)
// setting up control signals (sel4, sel3, sel2, sel1, sel0) for the five stages of 4:1 muxes 
//based on the shift type and the shift amount to be performed by each stage
    begin
        casex ({c, b[4]})               //MSB set; 16-bit shift to be done
            3 'bxx0 : sel4 = 2 'b11;
            3 'b0x1 : sel4 = 2 'b10;
            3 'b111 : sel4 = 2 'b01;
            3 'b101 : sel4 = 2 'b00;
            default: sel4 = 2'd0;
        endcase 
        
        casex ({c, b[3]})               //set; 8-bit shift to be done
            3 'bxx0 : sel3 = 2 'b11;
            3 'b0x1 : sel3 = 2 'b10;
            3 'b111 : sel3 = 2 'b01;
            3 'b101 : sel3 = 2 'b00;
            default: sel3 = 2'd0;
        endcase
        
        casex ({c, b[2]})               //set; 4-bit shift to be done
            3 'bxx0 : sel2 = 2 'b11;
            3 'b0x1 : sel2 = 2 'b10;
            3 'b111 : sel2 = 2 'b01;
            3 'b101 : sel2 = 2 'b00;
            default: sel2 = 2'd0;
        endcase
        
        casex ({c, b[1]})               //set; 2-bit shift to be done
            3 'bxx0 : sel1 = 2 'b11;
            3 'b0x1 : sel1 = 2 'b10;
            3 'b111 : sel1 = 2 'b01;
            3 'b101 : sel1 = 2 'b00;
            default: sel1 = 2'd0;
        endcase
        
        casex ({c, b[0]})               //set; 1-bit shift to be done
            3 'bxx0 : sel0 = 2 'b11;        //no shift if bit is not active
            3 'b0x1 : sel0 = 2 'b10;        //left shift
            3 'b111 : sel0 = 2 'b01;        //asr
            3 'b101 : sel0 = 2 'b00;        //right shift
            default: sel0 = 2'd0;
        endcase
        
//SHIFTING        
//shift stage 4: performs 16/0-bit shift of the specified type on the input a
         case (sel4)
            2 'b11 : z4 = a;                        //no shift
            2 'b10 : z4 = {a[15 : 0], {16{1 'b0}}}; //Left shift
            2 'b01 : z4 = {{16{a[31]}}, a[31 : 16]};//arithmetic right shift
            2 'b00 : z4 = {{16{1 'b0}}, a[31 : 16]};//logical right shift
        endcase
//shift stage 3: performs 8/0-bit shift of the specified type on its input z4
        case (sel3)
            2 'b11 : z3 = z4;                       //no shift
            2 'b10 : z3 = {z4[23 : 0], {8{1 'b0}}}; //Left shift
            2 'b01 : z3 = {{8{z4[31]}}, z4[31 : 8]};//arithmetic right shift
            2 'b00 : z3 = {{8{1 'b0}}, z4[31 : 8]}; //logical right shift
        endcase
//shift stage 3: performs 4/0-bit shift of the specified type on its input z3
        case (sel2)
            2 'b11 : z2 = z3; //no shift
            2 'b10 : z2 = {z3[27 : 0], {4{1 'b0}}};//Left
            2 'b01 : z2 = {{4{z3[31]}}, z3[31 : 4]};//arithmethic right shift
            2 'b00 : z2 = {{4{1 'b0}}, z3[31 : 4]};
        endcase
//shift stage 3: performs 2/0-bit shift of the specified type on its input z2        
        case (sel1)
            2 'b11 : z1 = z2; //no shift
            2 'b10 : z1 = {z2[29 : 0], {2{1 'b0}}}; //Left
            2 'b01 : z1 = {{2{z2[31]}}, z2[31 : 2]};//arithmethic right shift
            2 'b00 : z1 = {{2{1 'b0}}, z2[31 : 2]}; //logical right shift
        endcase
//shift stage 3: performs 1/0-bit shift of the specified type on its input z1    
        case (sel0)
            2 'b11 : z = z1;                        //no shift
            2 'b10 : z = {z1[30 : 0], 1 'b0};       //left shift
            2 'b01 : z = {{z1[31]}, z1[31 : 1]};    //arithmethic right shift
            2 'b00 : z = {1 'b0, z1[31 : 1]};       //logical right shift
        endcase
end
//always block end
endmodule
