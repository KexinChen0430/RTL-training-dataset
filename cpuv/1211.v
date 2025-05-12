module alu_control (
  input [5:0] funct,   
  input [2:0] alu_op,  
  output [3:0] aluctrl 
);
  reg [3:0] funct_val;   
  reg [3:0] aluctrl_val; 
  always @(*) begin
    case(funct)
      `AND_FUNCT  : funct_val =  `AND;  
      `OR_FUNCT   : funct_val =  `OR;   
      `ADD_FUNCT  : funct_val =  `ADD;  
      `SUB_FUNCT  : funct_val =  `SUB;  
      `SLT_FUNCT  : funct_val =  `SLT;  
      `NOR_FUNCT  : funct_val =  `NOR;  
      default: funct_val= 0;             
    endcase
  end
  always @(*) begin
    aluctrl_val <= 0; 
    case (alu_op)
      `LW   : aluctrl_val <= 4'd2; 
      `BEQ  : aluctrl_val <= 4'd6; 
      `ORI  : aluctrl_val <= 4'd1; 
      `ANDI : aluctrl_val <= 4'd0; 
      3'd2  : aluctrl_val <= funct_val; 
      default: aluctrl_val <= 0;        
    endcase
  end
  assign aluctrl = aluctrl_val;
endmodule