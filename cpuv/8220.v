module reg_based_cam (
	clk,rst,
	waddr,wdata,wcare,wena,
	lookup_data,match_lines
); 
parameter DATA_WIDTH = 32; 
parameter ADDR_WIDTH = 4; 
parameter WORDS = (1<<ADDR_WIDTH); 
input clk,rst; 
input [ADDR_WIDTH-1:0] waddr; 
input [DATA_WIDTH-1:0] wdata,wcare; 
input wena; 
input [DATA_WIDTH-1:0] lookup_data; 
output [WORDS-1:0] match_lines; 
wire [WORDS-1:0] match_lines; 
wire [WORDS-1:0] word_wena; 
reg [WORDS-1:0] waddr_dec; 
always @(*) begin
    waddr_dec = 0; 
    waddr_dec[waddr] = 1'b1; 
end
assign word_wena = waddr_dec & {WORDS{wena}};
wire wused = |wcare ;
genvar i; 
generate
  for (i=0; i<WORDS; i=i+1)
  begin : cw
    reg_cam_cell c ( 
		.clk(clk),
		.rst(rst),
		.wdata(wdata),
		.wcare(wcare),
		.wused(wused),
		.wena(word_wena[i]),
		.lookup_data(lookup_data),
		.match(match_lines[i])
    );
    defparam c .DATA_WIDTH = DATA_WIDTH; 
  end
endgenerate
endmodule 