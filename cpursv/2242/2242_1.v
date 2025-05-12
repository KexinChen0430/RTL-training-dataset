
module INSTRUCTION_FETCH_STAGE  #(parameter  ADDRESS_WIDTH = 32, HIGH = 1'b1, LOW = 1'b0)
  (input  CLK,
   input  STALL_INSTRUCTION_FETCH_STAGE,
   input  CLEAR_INSTRUCTION_FETCH_STAGE,
   input  [(-1)+ADDRESS_WIDTH:0] PC_IN,
   input  PC_VALID_IN,
   output [(-1)+ADDRESS_WIDTH:0] PC_OUT,
   output PC_VALID_OUT);

  reg  [(-1)+ADDRESS_WIDTH:0] pc_reg;
  reg  pc_valid_reg;

  
  always @(posedge CLK)
      begin
        if (CLEAR_INSTRUCTION_FETCH_STAGE == LOW) 
          begin
            if (STALL_INSTRUCTION_FETCH_STAGE == LOW) 
              begin
                pc_reg <= PC_IN;
                pc_valid_reg <= PC_VALID_IN;
              end
              
          end
        else 
          begin
            pc_reg <= 32'b0;
            pc_valid_reg <= LOW;
          end
      end
  assign PC_OUT = pc_reg;
  assign PC_VALID_OUT = pc_valid_reg;
endmodule

