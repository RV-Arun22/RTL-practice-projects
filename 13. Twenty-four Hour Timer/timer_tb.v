module timer_tb();
    reg clk, rst;
    wire [5:0] s,m,h;
    
    timer t1 (clk, rst, s, m, h);
    
    always #5 clk = ~clk;
    
    initial
        begin
            clk = 1'b0; rst = 1'b1;
            #7 rst = 1'b0;
            #5000 rst = 1'b1;
            #2 $finish;
        end    
endmodule
