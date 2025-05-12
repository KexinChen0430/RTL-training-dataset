module dividerp1(input wire clk,
                 input wire [17:0] pos,
                 input wire timer_ena,
                 output wire clk_out);
parameter M = `T_20ms;
parameter N = 18;
reg [N-1:0] divcounter = 0;
always @(posedge clk)
    if (timer_ena)
      divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1;
    else
      divcounter <= 0;
assign clk_out = (divcounter < pos) ? 1 : 0;
endmodule