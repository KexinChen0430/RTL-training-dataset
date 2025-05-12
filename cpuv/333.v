module sign_extender (
  input [25:0] immediate_jump,  
  output [31:0] extended_jump   
);
  wire extended_jump_31;
  assign extended_jump[31] = extended_jump_31;
  assign extended_jump[30] = extended_jump_31;
  assign extended_jump[29] = extended_jump_31;
  assign extended_jump[28] = extended_jump_31;
  assign extended_jump[27] = extended_jump_31;
  assign extended_jump[26] = extended_jump_31;
  assign extended_jump_31 = immediate_jump[25];
  assign extended_jump[24:0] = immediate_jump[24:0];
endmodule