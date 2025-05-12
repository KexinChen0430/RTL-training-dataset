module m23({a[7], a[6:0]},); 
input a;                      
wire [15:0] a;                
initial #1 test.sum[23] = test.sum[23] + a[7:0]; 
endmodule