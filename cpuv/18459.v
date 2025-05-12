module check(
   in, clk, cyc
   );
   parameter WIDTH = 128;
   input [127:0] in;
   wire [WIDTH-1:0] ci = in[WIDTH-1:0];
   wire signed [WIDTH-1:0] cis = in[WIDTH-1:0];
   real r;
   real rs;
   always_comb r = ci;
   always_comb rs = cis;
   input clk;
   input integer cyc;
   real          sum;
   always_ff @ (negedge clk) begin
`ifdef TEST_VERBOSE
      $write("[%0t] w%0d in=%h r=%f rs=%f sum=%f\n", $time, WIDTH, ci, r, rs, sum);
`endif
      if (cyc < 10) sum <= 0;
      else sum <= sum + r + rs;
   end
endmodule