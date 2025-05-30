
module dffn(q,d,clk);

  parameter  BITS = 1;
  input  [BITS+(0-1):0] d;
  output reg [BITS+(0-1):0] q;
  input  clk;

  
  always @(posedge clk)  begin
    q <= d;
  end
endmodule

