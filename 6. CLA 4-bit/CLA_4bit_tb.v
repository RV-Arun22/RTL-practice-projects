`timescale 1ns / 1ps
module CLA_4bit_tb();
    reg cin;
    reg [3:0] A,B;
    wire cout;
    wire [3:0] sum;

    integer q;
    CLA_4bit adder1 (cin, A, B, cout, sum);
    initial
        begin
            cin = 1'b0; A = 4'd0; B = 4'b0;
            for (q = 0; q < 16; q = q + 1)
                begin
                    #2 A = q;
                    #2 B = q+1;
                    #2 cin = cin + 1;
                end
            #5 $finish;
        end          
endmodule
