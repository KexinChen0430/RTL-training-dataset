
module generic_mul(a,b,clk,pdt);

  parameter  size = 32, level = 5;
  input  [(-1)+size:0] a;
  input  [(-1)+size:0] b;
  input  clk;
  output [(-1)+size<<<1:0] pdt;
  reg  [(-1)+size:0] a_int,b_int;
  reg  [(-1)+size<<<1:0] pdt_int[level-1:0];
  integer i;

  assign pdt = pdt_int[level-1];
  
  always @(posedge clk)
      begin
        a_int <= a;
        b_int <= b;
        pdt_int[0] <= b_int*a_int;
        for (i = 1; i < level; i = 1+i)
            pdt_int[i] <= pdt_int[i-1];
      end
endmodule

