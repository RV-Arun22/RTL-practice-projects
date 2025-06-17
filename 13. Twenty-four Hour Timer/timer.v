module timer(
    input clk, rst,
    output reg [5:0] s, m, h
    );

  //assuming a clock of 1 sec is given as input to this module from a clock frequency divider module

  always @ (posedge clk)
		begin
				if (rst == 1'b1)
						begin
								s <= 0;
								m <= 0;
								h <= 0;
						end
				else
						begin
							if (s < 59)					//seconds counter
									s <= s + 1;
							else begin					//minutes counter
									s <= 0;
									if (m < 59)
											m <= m + 1;
									else begin			//hours counter  
											m <= 0;
											if (h < 23)
													h <= h + 1;
											else begin
													h <= 0;
											end
									end    //hrs end
							end    //mins end
						end    //sec end			
		end   //always end
endmodule
