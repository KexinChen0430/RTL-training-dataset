module 
input request_p1;		
input request_p2;		
input enable;			
input reset;			
input clk;			
always @(reset) begin		
	if (reset) begin	
	end
end
always @*	
begin
	if(enable)	
	begin
		case ({request_p1,request_p2})	
			2'b11: 	begin	
						grant1 = `BUS_GRANTED;	
						grant2 = `BUS_NOT_GRANTED;	
					end
			2'b01:	begin	
						grant1 = `BUS_NOT_GRANTED;	
						grant2 = `BUS_GRANTED;	
					end
			2'b10:	begin	
						grant1 = `BUS_GRANTED;	
						grant2 = `BUS_NOT_GRANTED;	
					end
			default: 	begin	
							grant1 = `BUS_GRANTED;	
							grant2 = `BUS_NOT_GRANTED;	
						end
		endcase
	end
end
endmodule	