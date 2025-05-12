module shiftreg #(parameter DEPTH = 8, WIDTH = 8) (data_in,data_out,CLK,RESET); 
input wire [WIDTH-1:0] data_in [DEPTH-1:0]; 
output reg [WIDTH-1:0] data_out [DEPTH-1:0]; 
reg [WIDTH-1:0] stage1 [DEPTH-1:0]; 
reg [WIDTH-1:0] stage2 [DEPTH-1:0]; 
input CLK; 
input RESET; 
always @(posedge CLK) begin 
	if (RESET) begin 
		for(integer i=0;i<DEPTH;i++) begin 
			stage1[i] <= {(WIDTH){1'b0}}; 
		end
	end else begin 
		stage1 <= data_in; 
		stage2 <= stage1; 
		data_out <= stage2; 
	end
end
endmodule 