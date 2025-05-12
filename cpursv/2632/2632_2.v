
module rom(PC,inst,clk);

  parameter  DATA_WIDTH = 32;
  input  [(-1)+DATA_WIDTH:0] PC;
  input  clk;
  output [(-1)+DATA_WIDTH:0] inst;
  reg  [(-1)+DATA_WIDTH:0] inst;

  
  always @(posedge clk)
      begin
        case (PC)

          default: inst <= 0;

        endcase

      end
endmodule

