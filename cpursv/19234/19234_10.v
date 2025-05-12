
module addersub(opA,opB,op,result,result_slt);

  parameter  WIDTH = 32;
  input  [WIDTH+(0-1):0] opA;
  input  [WIDTH+(0-1):0] opB;
  input  [3+(0-1):0] op;
  output [WIDTH+(0-1):0] result;
  output result_slt;
  wire carry_out;
  reg  [WIDTH:0] sum;
  wire is_slt;
  wire signext;
  wire addsub;

  assign is_slt = op[2];
  assign signext = op[1];
  assign addsub = op[0];
  assign result = sum[WIDTH+(0-1):0];
  assign result_slt = sum[WIDTH];
  wire [WIDTH+(0-1):0] oA;

  wire [WIDTH+(0-1):0] oB;

  wire [WIDTH+(0-1):0] o_B;

  assign oA = {opA[WIDTH+(0-1)] & signext,opA};
  assign oB = {opB[WIDTH+(0-1)] & signext,opB};
  assign o_B = 1'b1+~{opB[WIDTH+(0-1)] & signext,opB};
  
  always @(*)
      begin
        if (addsub == 1'b1) 
          begin
            sum = oB+oA;
          end
        else 
          begin
            sum = o_B+oA;
          end
      end
  assign carry_out = sum[WIDTH];
endmodule

