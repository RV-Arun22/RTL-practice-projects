module demux_1x8(
    input I,
    input [2:0] sel,
    input enable,
    output [7:0] y
    );
    reg [7:0] Y;
    always  @ (*)
        begin
            Y = 8'd0;
            if (enable)     //active high enable
                Y = 8'd0;
            else
                begin
                    case (sel)
                    3'd0: Y[0] = I;
                    3'd1: Y[1] = I;
                    3'd2: Y[2] = I;
                    3'd3: Y[3] = I;
                    3'd4: Y[4] = I;
                    3'd5: Y[5] = I;
                    3'd6: Y[6] = I;
                    3'd7: Y[7] = I;
                    default: Y = 8'd0;
                    endcase
                end
        end
    assign y = Y;      
endmodule
