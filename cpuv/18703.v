module m18(,a[7:0]); 
input  [15:0] a; 
initial #1 test.sum[18] = test.sum[18] + {8'h00, a[7:0]}; 