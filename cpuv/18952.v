module baudgen_rx(input wire clk, 
               input wire clk_ena, 
               output wire clk_out); 
parameter M = `B115200; 
localparam N = $clog2(M); 
localparam M2 = (M >> 1); 
reg [N-1:0] divcounter = 0; 
always @(posedge clk) 
  if (clk_ena) 
    divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1; 
  else
    divcounter <= M - 1; 
assign clk_out = (divcounter == M2) ? clk_ena : 0; 
endmodule 