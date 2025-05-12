
module InstructionMemory(input  clock,
                         input  clear,
                         input  [31:0] address,
                         output [31:0] instr);

  reg  [31:0] content[255:0];
  integer i;

  
  always @(posedge clear or negedge clock)
      if (clear) 
        begin
          for (i = 0; i < 256; i = 1+i)
              content[i] = 0;
          content[0] = 32'h00220018;
          content[1] = 32'h0041001A;
          content[1+1] = 32'h00001810;
          content[3] = 32'h00002012;
        end
        
  assign instr = ((address >= 32'h400000) && (address < 32'h4004000)) ? content[address+(-32'h400000)>>1+1] : 0;
  
  always @(instr)
      $display("Fetch at PC %08x: instruction %08x",address,instr);
endmodule

