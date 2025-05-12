
module multfix(clk,rst,a,b,q_sc,q_unsc);

  parameter  WIDTH = 35;
  input  [WIDTH-1:0] a,b;
  output [WIDTH-1:0] q_sc;
  output [WIDTH-1:0] q_unsc;
  input  clk,rst;
  reg  [WIDTH<<<1-1:0] q_0;
  reg  [WIDTH<<<1-1:0] q_1;
  wire [WIDTH<<<1-1:0] res;

  assign res = q_1;
  assign q_unsc = res[WIDTH-1:0];
  assign q_sc = {res[WIDTH<<<1-1],res[WIDTH<<<1+(0-4):WIDTH-1<<1]};
  
  always @(posedge clk)
      begin
        q_0 <= b*a;
        q_1 <= q_0;
      end
endmodule

