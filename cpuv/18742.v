module m21({a[7], a[6:0]}, {b[15], b[14:0]});
   input  a;             
   output b;             
   wire [7:0] a;         
   reg [15:0] b;         
   initial #1 b = test.sum[21] + {8'h00, a[7:0]};
endmodule