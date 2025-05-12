
module generic_mul(a,b,clk,pdt);

  parameter  size = 32, level = 5;
  input  [size-1:0] a;
  input  [size-1:0] b;
  input  clk;
  output [size<<1+(-1):0] pdt;
  reg  [size-1:0] a_int,b_int;
  reg  [size<<1+(-1):0] pdt_int[(-1)+level:0];
  integer i;

  assign pdt = pdt_int[(-1)+level];
  
  always @(posedge clk)
      begin
        a_int <= a;
        b_int <= b;
        pdt_int[0] <= a_int*b_int;
        for (i = 1; i < level; i = i+1)
            pdt_int[i] <= pdt_int[(-1)+i];
      end
endmodule

