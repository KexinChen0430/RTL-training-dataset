module m20({a[7], a[6:0]}); 
input a; 
wire [15:0] a; 
initial #1 test.sum[20] = test.sum[20] + {8'h00, a[7:0]}; 
endmodule 