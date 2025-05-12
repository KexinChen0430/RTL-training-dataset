module MUXFULLPARALELL_3SEL_WALKINGONE # ( parameter SIZE=`WIDTH )
(
  input wire [2:0] Sel,
  input wire [SIZE-1:0] I1, I2, I3,
  output reg [SIZE-1:0] O1
);
always @( * )
  begin
    case (Sel)
      3'b001: O1 = I1;
      3'b010: O1 = I2;
      3'b100: O1 = I3;
      default: O1 = SIZE;
    endcase
  end
endmodule