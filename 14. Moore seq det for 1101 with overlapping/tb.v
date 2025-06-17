module fsm_tb();
    reg clk, rst, ip;
    wire out;
    wire [2:0] state;
    
    detector_fsm fsm (clk, rst, ip, out, state);
    
    always #5 clk = ~clk;
    
    initial
        begin
            clk = 1'b0; rst = 1'b1; ip = 1'b0;
            #7 rst = 1'b0; ip = 1'b0;
            #5 ip = 1'b1;
            #10 ip = 1'b1;
            #10 ip = 1'b1;
            #10 ip = 1'b1;
            #10 ip = 1'b0;
            #10 ip = 1'b1;
            #10 ip = 1'b1;
            #10 ip = 1'b0;
            #10 ip = 1'b1;
            #10 ip = 1'b1;
            #10 ip = 1'b0;
            #10 ip = 1'b0;
            #10 ip = 1'b1;
            #1 $finish;            
        end
endmodule
