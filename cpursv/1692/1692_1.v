
module INSTR_MEM(input  clk,
                 input  [31:0] addr,
                 output reg [31:0] data);

  reg  [31:0] MEM[128:0];

  
  initial  
  begin
    MEM[0] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000;
    MEM[1] <= 32'b001000_00001_00001_0000000000000001;
    MEM[2] <= 32'b001000_00010_00010_0000000000000010;
  end
  
  always @* 
      begin
        data <= MEM[addr];
      end
endmodule

