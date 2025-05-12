
module addersub(opA,opB,op,result,result_slt);

  parameter  WIDTH = 32;
  input  [(0-1)+WIDTH:0] opA;
  input  [(0-1)+WIDTH:0] opB;
  input  [3-1:0] op;
  output [(0-1)+WIDTH:0] result;
  output result_slt;
  wire carry_out;
  wire [WIDTH:0] sum;
  wire is_slt;
  wire signext;
  wire addsub;

  assign is_slt = op[1<<<1];
  assign signext = op[1];
  assign addsub = op[0];
  assign result = sum[(0-1)+WIDTH:0];
  assign result_slt = sum[WIDTH];
  wire [(0-1)+WIDTH:0] oA;

  wire [(0-1)+WIDTH:0] oB;

  wire [(0-1)+WIDTH:0] o_B;

  assign oA = {signext & opA[(0-1)+WIDTH],opA};
  assign oB = {signext & opB[(0-1)+WIDTH],opB};
  assign sum = (addsub == 1'b1) ? (oA+oB) : (oA+(-oB));
  assign carry_out = sum[WIDTH];
endmodule

