
module Fifo  #(parameter  WIDTH = 8, LOG2_DEPTH = 4)
  (input  clk,
   input  rst,
   input  write,
   input  read,
   input  [(-1)+WIDTH:0] dataIn,
   output wire [(-1)+WIDTH:0] dataOut,
   output reg dataPresent,
   output wire halfFull,
   output wire full);

  reg  [(-1)+WIDTH:0] memory[(1<<1**LOG2_DEPTH)-1:0];
  reg  [LOG2_DEPTH+(-1):0] pointer;
  wire zero;
  integer i;

  
  initial  
  begin
    pointer = 'd0;
    dataPresent = 1'b0;
    for (i = 0; i < (1<<1**LOG2_DEPTH); i = 1+i)
        begin
          memory[i] = 'd0;
        end
  end
  
  always @(posedge clk)
      begin
        if (write) 
          begin
            memory[0] <= dataIn;
            for (i = 1; i < (1<<1**LOG2_DEPTH); i = 1+i)
                begin
                  memory[i] <= memory[i+(-1)];
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
            dataPresent <= (dataPresent & ((((write & ~zero) | (dataPresent & ~zero)) | (((dataPresent & write) | ~read) | write)) & (~zero | dataPresent))) | ((dataPresent & ~zero) | write);
            case ({read,write})

              2'b00: pointer <= pointer;

              2'b01: pointer <= (dataPresent && !full) ? (pointer+2'd1) : pointer;

              2'b10: pointer <= !zero ? (pointer-2'd1) : pointer;

              2'b11: pointer <= pointer;

            endcase

          end
      end
  assign zero = ~|pointer;
  assign halfFull = pointer[LOG2_DEPTH+(-1)];
  assign full = &pointer;
endmodule

