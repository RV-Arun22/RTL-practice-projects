`timescale 1ns / 1ps
module encoder_8x3_tb();

    reg [7:0] ip;
    wire [2:0] op;
    integer k;
    
    encoder_8x3_new enc1 (ip, op);
    
    initial
        begin
            ip = 0;
//            for ( k = 0; k < 8; k = k + 1)
//                begin
//                    #2 ip = k;
//                end
            #2 ip = 8'b01011011;
            #2 ip = 8'b00000001;
            #2 ip = 8'b00000111;
            #2 $finish;
        end

endmodule
