module CC_DFF #(
	parameter [0:0] CLK_INV = 1'b0, 
	parameter [0:0] EN_INV  = 1'b0, 
	parameter [0:0] SR_INV  = 1'b0, 
	parameter [0:0] SR_VAL  = 1'b0  
)(
	input D,                        
	(* clkbuf_sink *)               
	input CLK,                      
	input EN,                       
	input SR,                       
	output reg Q                    
);
	wire clk, en, sr;
	assign clk = (CLK_INV) ? ~CLK : CLK; 
	assign en  = (EN_INV)  ?  ~EN :  EN; 
	assign sr  = (SR_INV)  ?  ~SR :  SR; 
	initial Q = 1'bX; 
	always @(posedge clk or posedge sr)
	begin
		if (sr) begin 
			Q <= SR_VAL; 
		end
		else if (en) begin 
			Q <= D; 
		end
	end
endmodule