
module Fifo  #(parameter  WIDTH = 8, LOG2_DEPTH = 4)
  (input  clk,
   input  rst,
   input  write,
   input  read,
   input  [WIDTH+(-1):0] dataIn,
   output wire [WIDTH+(-1):0] dataOut,
   output reg dataPresent,
   output wire halfFull,
   output wire full);

  reg  [WIDTH+(-1):0] memory[(-1)+(1<<<1**LOG2_DEPTH):0];
  reg  [LOG2_DEPTH-1:0] pointer;
  wire zero;
  integer i;

  
  initial  
  begin
    pointer = 'd0;
    dataPresent = 1'b0;
    for (i = 0; i < (1<<<1**LOG2_DEPTH); i = i+1)
        begin
          memory[i] = 'd0;
        end
  end
  
  always @(posedge clk)
      begin
        if (write) 
          begin
            memory[0] <= dataIn;
            for (i = 1; i < (1<<<1**LOG2_DEPTH); i = i+1)
                begin
                  memory[i] <= memory[i-1];
                end
          end
          
      end
  assign dataOut = memory[pointer];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            pointer <= 'd0;
            dataPresent <= 1'b0;
          end
        else 
          begin
            dataPresent <= (((dataPresent & (~zero | write)) & ~zero) | (write & ~zero)) | ((((zero & ~read) & (((~read & (~zero | (zero & dataPresent))) & dataPresent) | (~zero | write))) & dataPresent) | write);
            case ({read,write})

              2'b00: pointer <= pointer;

              2'b01: pointer <= (!full && dataPresent) ? (2'd1+pointer) : pointer;

              2'b10: pointer <= !zero ? (pointer-2'd1) : pointer;

              2'b11: pointer <= pointer;

            endcase

          end
      end
  assign zero = ~|pointer;
  assign halfFull = pointer[LOG2_DEPTH-1];
  assign full = &pointer;
endmodule

