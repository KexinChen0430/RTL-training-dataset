
module branch_detector(opcode,func,is_branch);

  input  [5:0] opcode;
  input  [5:0] func;
  output is_branch;
  wire is_special;

  assign is_special = !|opcode;
  assign is_branch = 
((func[5:3] == 3'b001) && 
(is_special || 
(
(
((is_special && !|opcode[5:3]) || 
(!is_special && (func[5:3] == 3'b001))) && (!|opcode[5:3] || is_special)) || 
(
(!is_special || 
((is_special && !|opcode[5:3]) || (func[5:3] == 3'b001))) && is_special)))) || (!is_special && !|opcode[5:3]);
endmodule

