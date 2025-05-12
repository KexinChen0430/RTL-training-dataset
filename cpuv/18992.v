module gfirTF
#(parameter
	C_IWIDTH = 16,   
	C_OWIDTH = 32,   
	C_CWIDTH = 16,   
	C_CLENGTH = 21   
)
(
	input                         clk           , 
	input                         sclr          , 
	input                         en            , 
	input  signed [C_IWIDTH-1:0]  din           , 
	output signed [C_OWIDTH-1:0]  dout            
);
	wire signed [C_CWIDTH-1:0] coeff_mem[0:C_CLENGTH-1]; 
	reg signed [C_IWIDTH-1:0] X_reg[0:C_CLENGTH-1];      
	wire signed [C_IWIDTH-1:0] X_k;                      
	assign coeff_mem[0] = 6;
	assign coeff_mem[20] = 6;
	integer i; 
	always @(posedge clk) begin 
		if (en==1'b1) begin 
			X_reg[0] <= 0 + X_k * coeff_mem[C_CLENGTH-1];
			for (i = 1; i <= C_CLENGTH-1; i = i + 1)
				X_reg[i] <= X_reg[i-1] + X_k * coeff_mem[C_CLENGTH-i-1];
		end
	end
	assign X_k  = din;
	assign dout = X_reg[C_CLENGTH-1];
	initial begin
		for (i = 0; i <= C_CLENGTH-1; i = i + 1)
			X_reg[i] <= 'h0;
	end
endmodule 