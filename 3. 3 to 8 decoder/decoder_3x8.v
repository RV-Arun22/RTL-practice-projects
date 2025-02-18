parameter Nd = 3;       //no of inputs to decoder. 
integer i;
module decoder_3x8 (
    input [(Nd-1):0] I,
    output reg [(2**Nd)-1:0] Y
    );
    
    always @ (*)
        begin
            Y = 0;      //to allow only one bit to go to '1' at the start.
            for ( i = 0; i<(2**Nd); i = i+1)
                begin
                    if (I == i)
                        Y[i] = 1'b1;
                    else 
                        Y[i] = 1'b0;
            end
        end
        
endmodule
