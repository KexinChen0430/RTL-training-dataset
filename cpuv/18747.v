module m12(a[0]); 
   input a; 
   wire [7:0] a; 
   initial #1 test.sum[12] = test.sum[12] + {test.data[7:1], a[0]};
endmodule 