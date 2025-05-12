module baudgen
    #(
    parameter BAUD = `B115200 
    )
(
    input wire clk,          
    input wire clk_ena,      
    output wire clk_out      
);
localparam N = $clog2(BAUD);
reg [N-1:0] divcounter = 0;
always @(posedge clk)
  if (clk_ena) 
    divcounter <= (divcounter == BAUD - 1) ? 0 : divcounter + 1;
  else 
    divcounter <= BAUD - 1;
assign clk_out = (divcounter == 0) ? clk_ena : 0;
endmodule