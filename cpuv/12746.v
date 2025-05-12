module counter) 
reg [N-1:0] divcounter = 0; 
always @(posedge clk) 
  if (!rstn) 
    divcounter <= 0; 
  else if (clk_ena) 
    divcounter <= (divcounter == BAUDRATE - 1) ? 0 : divcounter + 1; 
  else 
    divcounter <= BAUDRATE - 1; 
assign clk_out = (divcounter == 0) ? clk_ena : 0; 
endmodule 