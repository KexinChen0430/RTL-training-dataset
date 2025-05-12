
module multfix(clk,rst,a,b,q_sc,q_unsc);

  parameter  WIDTH = 35;
  input  [WIDTH+(0-1):0] a,b;
  output [WIDTH+(0-1):0] q_sc;
  output [WIDTH+(0-1):0] q_unsc;
  input  clk,rst;
  reg  [(0-1)+((1+1)*WIDTH):0] q_0;
  reg  [(0-1)+((1+1)*WIDTH):0] q_1;
  wire [(0-1)+((1+1)*WIDTH):0] res;

  assign res = q_1;
  assign q_unsc = res[WIDTH+(0-1):0];
  assign q_sc = {res[(0-1)+((1+1)*WIDTH)],res[((1+1)*WIDTH)+(-4):WIDTH-(1+1)]};
  
  always @(posedge clk)
      begin
        q_0 <= b*a;
        q_1 <= q_0;
      end
endmodule

