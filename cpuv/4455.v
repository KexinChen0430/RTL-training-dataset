module logicBlock(
		  stateA, maskA, stateB, maskB, constant, opBMux,
		  prevConfigInvalid,
		  resultMux, out,
		  configInvalid
);
   input [31:0] stateA;
   input [31:0] stateB;
   input [31:0] maskA;     
   input [31:0] maskB;     
   input [31:0] constant;  
   input        opBMux;    
   input [2:0]  resultMux; 
   input        prevConfigInvalid;
   output       out;
   output       configInvalid;
   reg          out;
   wire         configInvalid;
   wire 	[31:0] maskedA = stateA & maskA;
   wire 	[31:0] operandA = maskedA;
   wire 	[31:0] maskedB = stateB & maskB;
   wire 	[31:0] operandB = opBMux ? maskedB : constant;
   wire 	eq = operandA == operandB;
   wire 	neq = operandA != operandB;
   wire 	gt = operandA > operandB;
   wire 	gteq = operandA >= operandB;
   wire 	lt = operandA < operandB;
   wire 	lteq = operandA `LTEQ operandB;
   assign configInvalid = prevConfigInvalid | (resultMux > 3'd5);
   always @(resultMux or eq or neq or gt or gteq or lt or lteq) begin
      case(resultMux)
	0: out = eq;
	1: out = neq;
	2: out = gt;
	3: out = gteq;
	4: out = lt;
	5: out = lteq;
	default : out = 0;
      endcase
   end
endmodule