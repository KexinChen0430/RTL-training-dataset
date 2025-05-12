module BoothController(input clk,input start,input[1:0] yLow, input[2:0] count,output reg ready,init,ldx,ldy,shift,cin,cntD); 
	reg [2:0] ps; 
	reg [2:0] ns; 
	initial ns = `RDY; 
	initial ps = `RDY; 
	always @(start,count,yLow,ps) 
		case(ps) 
			`RDY : ns = (start) ? `INT : `RDY; 
			`INT : ns = `CTD; 
			`CTD : ns = (count) ? (yLow[1]^yLow[0] ? (yLow[0] ? `ADD : `SUB) : `SHP) : `RDY; 
			`ADD : ns = `SHP; 
			`SUB : ns = `SHP; 
			`SHP : ns = `CTD; 
		endcase
	always @(posedge clk) 
		ps = ns; 
	always @(ps) 
		begin
			ready = 1'b0; 
			init = 1'b0; 
			ldx = 1'b0; 
			ldy = 1'b0; 
			shift = 1'b0; 
			cin = 1'b0; 
			cntD = 1'b0; 
			case(ps) 
				`INT : 
					begin
						ldx = 1'b1; 
						ldy = 1'b1; 
						init = 1'b1; 
					end
				`SHP : 
					shift = 1'b1; 
				`CTD : 
					cntD = 1'b1; 
				`ADD : 
					ldy = 1'b1; 
				`SUB : 
					begin
						ldy = 1'b1; 
						cin = 1'b1; 
					end
				`RDY : 
					ready = 1'b1; 
			endcase
		end
endmodule