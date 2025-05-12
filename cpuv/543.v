module and will not accept new data from the fifo
	output state;		
	reg[3:0] state;	
	parameter RESET         = 0;	
	parameter WAIT          = 1;	
	parameter WAIT2         = 2;	
	parameter WAIT3         = 3;	
	parameter DATA_COMING   = 4;	
	parameter DATA_COMING_2 = 5;	
	parameter DATA_COMING_3 = 6;	
	parameter DATA_COMING_4 = 7;	
	parameter DATA_COMING_5 = 8;	
	parameter DATA_HERE     = 9;	
	parameter DATA_LEAVING  = 10;	
	parameter DATA_LEAVING_2= 11;	
	parameter DATA_LEAVING_3= 12;	
	parameter DATA_LEAVING_4= 13;	
	parameter DATA_LEAVING_5= 14;	
	parameter DATA_LEAVING_6= 15;	
	initial
		state <= WAIT;
	always @ (posedge clk)
		if(reset)
			begin
				newout <= 0;		
				rd <= 1;			
				state <= WAIT;		
			end
		else if(~hold)			
			begin
				newout <= 0;		
				case(state)		
					WAIT:
						if(~rxf)	
							begin
								rd <= 1;			
								state <= WAIT2;		
							end
					default:
						state <= WAIT;	
				endcase
			end
endmodule