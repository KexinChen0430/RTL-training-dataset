module \$specrule (EN_SRC, EN_DST, SRC, DST);
parameter TYPE = "";
parameter T_LIMIT = 0;
parameter T_LIMIT2 = 0;
parameter SRC_WIDTH = 1;
parameter DST_WIDTH = 1;
parameter SRC_PEN = 0;
parameter SRC_POL = 0;
parameter DST_PEN = 0;
parameter DST_POL = 0;
input EN_SRC, EN_DST;
input [SRC_WIDTH-1:0] SRC;
input [DST_WIDTH-1:0] DST;
`ifdef SIMLIB_SPECIFY
specify
endspecify
`endif
endmodule