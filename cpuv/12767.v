module sign_extender ( immediate_jump, extended_jump );
  input [25:0] immediate_jump;
  output [31:0] extended_jump;
  assign extended_jump[25] = immediate_jump[25]; 
  assign extended_jump[26] = immediate_jump[25]; 
  assign extended_jump[27] = immediate_jump[25]; 
  assign extended_jump[28] = immediate_jump[25]; 
  assign extended_jump[29] = immediate_jump[25]; 
  assign extended_jump[30] = immediate_jump[25]; 
  assign extended_jump[31] = immediate_jump[25]; 
  assign extended_jump[24:0] = immediate_jump[24:0]; 
endmodule