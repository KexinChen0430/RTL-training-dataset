module counter)
reg [N-1:0] divcounter = 0;
always @(posedge clk)
  if (clk_ena)
    divcounter <= (divcounter == BAUDRATE - 1) ? 0 : divcounter + 1;
  else
    divcounter <= BAUDRATE - 1;
assign clk_out = (divcounter == 0) ? clk_ena : 0;
endmodule