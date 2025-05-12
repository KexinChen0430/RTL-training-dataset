
module ProgramCounter(input  clk,
                      input  ce,
                      input  [1:0] LoadPC,
                      input  GotInterrupt,
                      input  [7:0] DIN,
                      input  [7:0] T,
                      output reg [15:0] PC,
                      output JumpNoOverflow);

  reg  [15:0] NewPC;

  assign JumpNoOverflow = ((NewPC[8] ^ PC[8]) == 0) & (LoadPC[1] & LoadPC[0]);
  
  always 
      begin
        case (LoadPC)

          0,1: NewPC = {15'b0,LoadPC[0] & ~GotInterrupt}+PC;

          2: NewPC = {DIN,T};

          3: NewPC = PC+{{8{T[7]}},T};

        endcase

      end
  
  always @(posedge clk)  if (ce) PC <= NewPC;
    
endmodule

