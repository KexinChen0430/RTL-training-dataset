
module sbox7(Bin,BSout);

  input  [6:1] Bin;
  output reg [4:1] BSout;
  wire [6:1] offset;

  assign offset = {Bin[6],Bin[1],Bin[5:2]};
  
  always @(offset)
      begin
        case (offset)

          6'b000000: BSout <= 4'd4;

          6'b000001: BSout <= 4'd11;

          6'b111111: BSout <= 4'd12;

          default: BSout <= 4'd0;

        endcase

      end
endmodule

