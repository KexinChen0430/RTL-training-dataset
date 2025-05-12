
module xlclkprobe(clk,clr,ce,fakeOutForXst);

  input  clk;
  input  clr;
  input  ce;
  output fakeOutForXst;

  assign fakeOutForXst = 1'b0;
  assign clock_pkg.int_clk = clk;
endmodule

