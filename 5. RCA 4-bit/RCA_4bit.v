module RCA_4bit(                    //4-bit RCA by instantiating 4 FAs
    input c_in,
    input [3:0] A,B,
    output c_out,
    output [3:0] S
    );
    wire C1,C2,C3;
    FA f0 (A[0], B[0], c_in, S[0], C1);
    FA f1 (A[1], B[1], C1, S[1], C2);
    FA f2 (A[2], B[2], C2, S[2], C3);
    FA f3 (A[3], B[3], C3, S[3], c_out);
endmodule



module FA(                  //Full adder module
    input a,b,c_in,
    output s, c_out
    );
    
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (b & c_in) | (c_in & a);
    
endmodule
