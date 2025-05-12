module m19(a[7:0],);
   input  [15:0] a;
   initial #1 test.sum[19] = test.sum[19] + {8'h00, a[7:0]};
endmodule