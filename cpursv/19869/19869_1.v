
module f9_test(q,d,clk,reset);

  output reg q;
  input  d,clk,reset;

  
  always @(posedge clk or negedge reset)
      if (!reset) q <= 0;
      else q <= d;
endmodule

