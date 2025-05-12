module m13(a[0], b[15:0]);
   input  a;
   output b;
   wire [7:0]  a;
   reg  [31:0] b;
   reg  [15:0] temp;
   initial begin
      #1 temp = test.sum[13] + {test.data[7:1], a[0]};
      b = temp;                                    
   end
endmodule