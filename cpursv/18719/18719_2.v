
module m17(a,b);

  input  a;
  output b;
  wire [7:0] a;
  reg  [31:0] b;

  
  initial    #1 b[15:0] = test.sum[17]+a;
endmodule

