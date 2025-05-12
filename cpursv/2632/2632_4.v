
module rom(PC,inst,clk);

  parameter  DATA_WIDTH = 32;
  input  [DATA_WIDTH+(-1):0] PC;
  input  clk;
  output [DATA_WIDTH+(-1):0] inst;
  reg  [DATA_WIDTH+(-1):0] inst;

  
  always @(posedge clk)
      begin
        case (PC)

          default: inst <= 0;

        endcase

      end
endmodule

