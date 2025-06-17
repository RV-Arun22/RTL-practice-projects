module synchr_FIFO_tb();
    reg clk, rst, wen, ren;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire full, empty;
    
    synchr_FIFO FIFO1 (clk, rst, data_in, wen, ren, data_out, full, empty);
    
    always # 5 clk = ~clk;
    
    initial 
        begin
            clk = 'b0; rst = 'b1; wen = 'b0; ren = 'b0; data_in = 0;
            #7 rst = 1'b0; 
            #5 wen = 1'b1; data_in = 'd1;
            #10 wen = 1'b1;data_in = 'd2;
//            #10 wen = 1'b1;
//            #10 wen = 1'b1;
//            #10 wen = 1'b1;
//            #10 wen = 1'b1;
//            #10 wen = 1'b1;
            
            #10 wen = 1'b0; ren = 1'b1;
            #10 ren = 1'b1;
            #10 ren = 1'b1;
            #10 $finish;
            
        end
endmodule
