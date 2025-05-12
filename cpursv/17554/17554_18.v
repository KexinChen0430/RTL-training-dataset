
module logic_unit(opB,opA,op,result);

  input  [31:0] opA;
  input  [31:0] opB;
  input  [1:0] op;
  output [31:0] result;
  reg  [31:0] logic_result;

  
  always @(opA or opB or op)
      case (op)

        2'b00: logic_result = opA & opB;

        2'b01: logic_result = opB | opA;

        2'b10: logic_result = (((opA ^ (opA & opB)) & (opB | opA)) | (opB | opA)) & (((opA ^ (opA & opB)) & (opB | opA)) | ~opA);

        2'b11: logic_result = ~(opB | opA);

      endcase

  assign result = logic_result;
endmodule

