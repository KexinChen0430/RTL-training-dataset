module dividerp1(
    input wire clk,         
    input wire timer_ena,   
    output wire clk_out     
);
parameter M = `T_100ms;
localparam N = $clog2(M);
reg [N-1:0] divcounter = 0;
always @(posedge clk)
    if (timer_ena)
        divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1;
    else
        divcounter <= 0;
assign clk_out = (divcounter == M - 1) ? 1 : 0;
endmodule