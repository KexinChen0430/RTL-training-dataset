
module addfxp(a,b,q,clk);

  parameter  width = 16;
  input  [(0-1)+width:0] a,b;
  input  clk;
  output [(0-1)+width:0] q;
  reg  [(0-1)+width:0] res;

  assign q = res[0];
  integer i;

  
  always @(posedge clk)
      begin
        res[0] <= a+b;
      end
endmodule

