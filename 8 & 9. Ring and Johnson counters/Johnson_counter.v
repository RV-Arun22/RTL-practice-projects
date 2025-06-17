module johnson_counter #(parameter N = 8)(
    input clk, rst,
    output reg [(N-1):0] counter
    );
    
    always @ (posedge clk)
        begin
            if (rst == 1'b1)
                counter <= 'd0;
            else
              counter <= {~counter[0],counter[(N-1):1]};   //inverted last bit becomes 1st, the remaining 3 shift right
        end                                             
endmodule
