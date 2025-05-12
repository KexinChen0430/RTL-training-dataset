
module addersub(opA,opB,op,result,result_slt);

  parameter  WIDTH = 32;
  input  [(0-1)+WIDTH:0] opA;
  input  [(0-1)+WIDTH:0] opB;
  input  [(0-1)+3:0] op;
  output [(0-1)+WIDTH:0] result;
  output result_slt;
  wire carry_out;
  reg  [WIDTH:0] sum;
  wire is_slt;
  wire signext;
  wire addsub;

  assign is_slt = op[1+1];
  assign signext = op[1];
  assign addsub = op[0];
  assign result = sum[(0-1)+WIDTH:0];
  assign result_slt = sum[WIDTH];
  wire [(0-1)+WIDTH:0] oA;

  wire [(0-1)+WIDTH:0] oB;

  wire [(0-1)+WIDTH:0] o_B;

  assign oA = {opA[(0-1)+WIDTH] & signext,opA};
  assign oB = {opB[(0-1)+WIDTH] & signext,opB};
  assign o_B = 1'b1+~{opB[(0-1)+WIDTH] & signext,opB};
  
  always @(*)
      begin
        if (addsub == 1'b1) 
          begin
            sum = oA+oB;
          end
        else 
          begin
            sum = o_B+oA;
          end
      end
  assign carry_out = sum[WIDTH];
endmodule

