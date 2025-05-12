module m22(,{a[7], a[6:0]}); 
   input  [15:0] a; 
   initial #1 test.sum[22] = test.sum[22] + {8'h00, a[7:0]}; 
endmodule 