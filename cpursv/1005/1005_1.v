
module addfxp(a,b,q,clk);

  parameter  width = 16, cycles = 1;
  input  signed  [width+(0-1):0] a,b;
  input  clk;
  output signed  [width+(0-1):0] q;
  reg  signed  [width+(0-1):0] res[cycles+(0-1):0];

  assign q = res[cycles+(0-1)];
  integer i;

  
  always @(posedge clk)
      begin
        res[0] <= b+a;
        for (i = 1; i < cycles; i = 1+i)
            res[i] <= res[i+(0-1)];
      end
endmodule

