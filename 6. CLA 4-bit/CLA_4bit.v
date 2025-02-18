module CLA_4bit(
    input c_in,
    input [3:0] A,B,
    output c_out,
    output reg [3:0] S
    );
    integer i;
    reg [3:0] g;       //generate signal
    reg [3:0] p;       //propagate signal
    reg [4:0] c;       //intermediate carries of ith bit 
    
    always @ (*)
        begin
            for (i = 0; i <= 3; i = i + 1)
                begin   
                    g[i] = A[i] & B[i];
                    p[i] = A[i] ^ B[i];
                end
            //carry calculation    
            c[0] = c_in;
            c[1] = g[0] | (p[0] & c[0]);
            c[2] = g[1] | (g[0] & p[1]) | (p[1] & p[0] & c[0]);
            c[3] = g[2] | (g[1] & p[2]) | (g[0] & p[2] & p[1]) | (p[2] & p[1] & p[0] & c[0]);
            c[4] = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]) | (p[3] & p[2] & p[1] & p[0] & c[0]);
            
            //sum calculation 
            for (i = 0; i <= 3; i = i + 1)
                begin
                    S[i] = A[i] ^ B[i] ^ c[i];
                end 
        end
    assign c_out = c[4];    
        
endmodule
