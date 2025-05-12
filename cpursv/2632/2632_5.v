
module rom(PC,inst,clk);

  parameter  DATA_WIDTH = 32;
  input  [(0-1)+DATA_WIDTH:0] PC;
  input  clk;
  output [(0-1)+DATA_WIDTH:0] inst;
  reg  [(0-1)+DATA_WIDTH:0] inst;

  
  always @(posedge clk)
      begin
        case (PC)

          default: inst <= 0;

        endcase

      end
endmodule

