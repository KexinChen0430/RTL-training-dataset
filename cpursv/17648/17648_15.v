
module addersub(opA,opB,op,result,result_slt);

  parameter  WIDTH = 32;
  input  [(-1)+WIDTH:0] opA;
  input  [(-1)+WIDTH:0] opB;
  input  [(-1)+3:0] op;
  output [(-1)+WIDTH:0] result;
  output result_slt;
  wire carry_out;
  wire [WIDTH:0] sum;
  wire is_slt;
  wire signext;
  wire addsub;

  assign is_slt = op[1+1];
  assign signext = op[1];
  assign addsub = op[0];
  assign result = sum[(-1)+WIDTH:0];
  assign result_slt = sum[WIDTH];
  wire [(-1)+WIDTH:0] oA;

  wire [(-1)+WIDTH:0] oB;

  wire [(-1)+WIDTH:0] o_B;

  assign oA = {signext & opA[(-1)+WIDTH],opA};
  assign oB = {opB[(-1)+WIDTH] & signext,opB};
  assign sum = (addsub == 1'b1) ? (oA+oB) : ((0-oB)+oA);
  assign carry_out = sum[WIDTH];
endmodule

