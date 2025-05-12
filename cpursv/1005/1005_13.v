
module addfxp(a,b,q,clk);

  parameter  width = 16, cycles = 1;
  input  signed  [(-1)+width:0] a,b;
  input  clk;
  output signed  [(-1)+width:0] q;
  reg  signed  [(-1)+width:0] res[(-1)+cycles:0];

  assign q = res[(-1)+cycles];
  integer i;

  
  always @(posedge clk)
      begin
        res[0] <= a+b;
        for (i = 1; i < cycles; i = 1+i)
            res[i] <= res[i-1];
      end
endmodule

