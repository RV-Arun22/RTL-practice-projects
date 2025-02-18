module mux_8x1(
    input [7:0] I,
    input [2:0] sel,
    output Y
    );
    
    assign Y = I[sel];
    
endmodule
