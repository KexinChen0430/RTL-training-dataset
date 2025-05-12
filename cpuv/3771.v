module \$ff (D, Q); 
parameter WIDTH = 0; 
input [WIDTH-1:0] D; 
output reg [WIDTH-1:0] Q; 
always @($global_clk) begin
	Q <= D; 
end
endmodule 