module MPUC1307 ( CLK, EI, ED, MPYJ, DR, DI, DOR, DOI );
	`FFT256paramnb
	input CLK;
	wire CLK;
	input EI;
	wire EI;
	input ED; 					
	input MPYJ;					
	wire MPYJ;
	input [nb-1:0] DR;			
	wire signed [nb-1:0] DR;
	input [nb-1:0] DI;			
	wire signed [nb-1:0] DI;
	output [nb:0] DOR;			
	reg [nb:0] DOR;
	output [nb:0] DOI;			
	reg [nb:0] DOI;
	reg signed [nb+2:0] dx5;
	reg signed [nb-1:0] dx7;
	reg signed [nb-1:0] dii;
	reg signed [nb:0] dt;
	wire signed [nb+3:0] dx5p;
	wire signed [nb+3:0] dot;
	reg edd, edd2, edd3;        
	reg mpyjd, mpyjd2, mpyjd3;
	reg [nb:0] doo;
	reg [nb:0] droo;
	always @(posedge CLK) begin
		if (EI) begin 
			edd <= ED;
			edd2 <= edd;
			edd3 <= edd2;
			mpyjd <= MPYJ;
			mpyjd2 <= mpyjd;
			mpyjd3 <= mpyjd2;
			if (ED) begin
				dx5 <= DR + (DR << 2); 
				dx7 <= DR - (DR >>> 3); 
				dt <= DR;
				dii <= DI;
			end else begin 
				dx5 <= dii + (dii << 2); 
				dx7 <= dii - (dii >>> 3); 
				dt <= dii;
			end
			doo <= dot >>> 3;
			droo <= doo;
			if (edd3) begin
				if (mpyjd3) begin
					DOR <= doo;
					DOI <= -droo; 
				end else begin
					DOR <= droo;
					DOI <= doo;
				end
			end
		end
	end
	assign dx5p = (dx5 << 1) + (dx7 >>> 1); 
	`ifdef FFT256bitwidth_coef_high
	assign dot = (dx5p + (dt >>> 6) - (dx5 >>> 13)); 
	`else
	assign dot = dx5p + (dt >>> 6); 
	`endif
endmodule