module m16(a[7:0]); 
input a; 
wire [15:0] a; 
initial #1 test.sum[16] = test.sum[16] + {8'h00, a[7:0]}; 