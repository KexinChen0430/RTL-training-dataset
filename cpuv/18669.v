module m15(a[0],);
   input  [7:0] a;
   initial #1 test.sum[15] = test.sum[15] + {test.data[7:1], a[0]};
endmodule