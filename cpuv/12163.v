module MPUC707 ( CLK,ED, DS, MPYJ,DR,DI ,DOR ,DOI  ); 
parameter total_bits = 32; 
input CLK ; 
wire CLK ; 
input DS ; 
wire DS ; 
input ED; 
input MPYJ ; 
wire MPYJ ; 
input [total_bits-1:0] DR ; 
wire signed [total_bits-1:0] DR ; 
input [total_bits-1:0] DI ; 
wire signed [total_bits-1:0] DI ; 
output [total_bits-1:0] DOR ; 
reg [total_bits-1:0] DOR ; 
output [total_bits-1:0] DOI ; 
reg [total_bits-1:0] DOI ; 
reg signed [total_bits+1 :0] dx5; 
reg signed [total_bits : 0] dt; 
reg signed [total_bits-1 : 0] dii; 
wire signed [total_bits+2 : 0] dx5p; 
wire signed [total_bits+3 : 0] dot; 
reg edd,edd2, edd3; 
reg mpyjd,mpyjd2,mpyjd3; 
reg [total_bits-1:0] doo ; 
reg [total_bits-1:0] droo ; 
always @(posedge CLK) 
	begin
		if (ED) begin 
			edd<=DS; 
			edd2<=edd; 
			edd3<=edd2; 
			mpyjd<=MPYJ; 
			mpyjd2<=mpyjd; 
			mpyjd3<=mpyjd2; 
			if (DS) begin 
				dx5<=DR+(DR <<2); 
				dt<=DR; 
				dii<=DI; 
			end
			else begin 
				dx5<=dii+(dii <<2); 
				dt<=dii; 
			end
			doo<=(dot >>>4) ; 
			droo<=doo; 
			if (edd3) 
				if (mpyjd3) begin 
					DOR<=doo; 
					DOI<= - droo; 
				end
				else begin 
					DOR<=droo; 
					DOI<=  doo; 
				end
		end
	end
assign dx5p=(dx5<<1)+(dx5>>>2); 
assign dot= dx5p+(dt>>>4)+(dx5>>>12); 
endmodule 