module dividerp1(
    input wire clk,        
    output wire clk_out    
);
parameter M = `T_100ms;
localparam N = $clog2(M);
reg [N-1:0] divcounter = 0;
always @(posedge clk)
    divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1;
assign clk_out = (divcounter == 0) ? 1 : 0;
endmodule