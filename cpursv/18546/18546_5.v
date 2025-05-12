
module dffn(q,d,clk);

  parameter  BITS = 1;
  input  [(-1)+BITS:0] d;
  output reg [(-1)+BITS:0] q;
  input  clk;

  
  always @(posedge clk)  begin
    q <= d;
  end
endmodule

