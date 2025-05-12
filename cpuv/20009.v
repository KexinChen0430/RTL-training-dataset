module $__XILINX_SHREG_(input C, D, input [1:0] L, output Q);
parameter CLKPOL = 1;
parameter ENPOL = 1;
parameter DEPTH = 2;
parameter [DEPTH-1:0] INIT = {DEPTH{1'b0}};
reg [DEPTH-1:0] r = INIT;
wire clk = C ^ CLKPOL;
always @(posedge C)
    r <= { r[DEPTH-2:0], D };
assign Q = r[L];
endmodule