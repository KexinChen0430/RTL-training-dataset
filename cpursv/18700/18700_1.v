
module m5(a,b);

  input  a;
  output b;
  wire [7:0] a;
  reg  [15:0] b;

  
  initial    #1 b <= test.sum[5]+a;
endmodule

