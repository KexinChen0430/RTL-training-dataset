
module addfxp(a,b,q,clk);

  parameter  width = 16;
  input  [width+(0-1):0] a,b;
  input  clk;
  output [width+(0-1):0] q;
  reg  [width+(0-1):0] res;

  assign q = res[0];
  integer i;

  
  always @(posedge clk)
      begin
        res[0] <= b+a;
      end
endmodule

