module MPUC924_383 ( CLK, EI, ED, MPYJ, C383, DR, DI, DOR, DOI );
	`FFT256paramnb
	input CLK; 
	wire CLK; 
	input EI; 
	wire EI; 
	input ED; 
	wire ED; 
	input MPYJ; 
	wire MPYJ; 
	input C383; 
	wire C383; 
	input [nb-1:0] DR; 
	wire signed [nb-1:0] DR; 
	input [nb-1:0] DI; 
	wire signed [nb-1:0] DI; 
	output [nb-1:0] DOR; 
	reg [nb-1:0] DOR; 
	output [nb-1:0] DOI; 
	reg [nb-1:0] DOI; 
	reg signed [nb+1 :0] dx7; 
	reg signed [nb :0] dx3; 
	reg signed [nb-1 :0] dii; 
	reg signed [nb-1 : 0] dt; 
	wire signed [nb+1 : 0] dx5p; 
	wire signed [nb+1 : 0] dot; 
	reg edd, edd2, edd3; 
	reg mpyjd, mpyjd2, mpyjd3; 
	reg c3d, c3d2, c3d3; 
	reg [nb-1:0] doo; 
	reg [nb-1:0] droo; 
	always @(posedge CLK)
		begin
			if (EI) begin 
					edd <= ED;
					edd2 <= edd;
					edd3 <= edd2;
					mpyjd <= MPYJ;
					mpyjd2 <= mpyjd;
					mpyjd3 <= mpyjd2;
					c3d <= C383;
					c3d2 <= c3d;
					c3d3 <= c3d2;
					if (ED) begin 
							dx7 <= (DR << 2) - (DR >>> 1); 
							dx3 <= DR + (DR >>> 1); 
							dt <= DR; 
							dii <= DI; 
						end
					else begin 
							dx7 <= (dii << 2) - (dii >>> 1); 
							dx3 <= dii + (dii >>> 1); 
							dt <= dii; 
					end
					if (c3d || c3d2) doo <= dot >>> 2; 
					else doo <= dot >>> 2; 
					droo <= doo;
					if (edd3) 
						if (mpyjd3) begin 
								DOR <= doo; 
								DOI <= -droo; 
							end
						else begin 
								DOR <= droo; 
								DOI <= doo; 
							end
				end
		end
	assign dx5p = (c3d || c3d2) ? ((dt >>> 5) + dx3) : (dx7 + (dx3 >>> 3)); 
	`ifdef FFT256bitwidth_coef_high
	assign dot = (c3d || c3d2) ? dx5p - (dt >>> 11) : (dx5p + ((dt >>> 7) + (dx3 >>> 13))); 
	`else
	assign dot = (c3d || c3d2) ? dx5p : (dx5p + (dt >>> 7)); 
	`endif
endmodule