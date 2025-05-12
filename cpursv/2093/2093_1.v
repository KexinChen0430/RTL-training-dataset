
module ROM_A(input  [31:0] addr,
             output [31:0] inst);

  reg  [31:0] instructions[128:0];

  
  initial  
  begin
    instructions[0] = 32'h00000026;
    instructions[66] = 32'h03e00008;
  end
  assign inst = instructions[addr];
endmodule

