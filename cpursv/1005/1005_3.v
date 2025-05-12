
module addfxp(a,b,q,clk);

  parameter  width = 16, cycles = 1;
  input  signed  [(0-1)+width:0] a,b;
  input  clk;
  output signed  [(0-1)+width:0] q;
  reg  signed  [(0-1)+width:0] res[(0-1)+cycles:0];

  assign q = res[(0-1)+cycles];
  integer i;

  
  always @(posedge clk)
      begin
        res[0] <= b+a;
        for (i = 1; i < cycles; i = i+1)
            res[i] <= res[i-1];
      end
endmodule

