module ring_counter_tb();   //testing for 8-bit counter
    reg clk, rst;
    wire [7:0] out;

    johnson_counter c1 (clk, rst, out);    //DUT is johnson counter
    //Ring__counter c2 (clk, rst, out);      //DUT is ring counter
    
    always #2 clk = ~clk;
    
    initial
        begin
            clk = 1'b0; rst = 1'b1;
            #9 rst = 1'b0;
            #100 $finish;
        end
endmodule
