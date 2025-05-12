module MUXFULLPARALELL_3SEL_GENERIC # ( parameter SIZE=`WIDTH )
(
    input wire [2:0] Sel,
    input wire [SIZE-1:0] I0, I1, I2, I3, I4, I5, I6, I7,
    output reg [SIZE-1:0] O
);
always @( * )
  begin
    case (Sel)
      3'd0: O = I0; 
      3'd1: O = I1; 
      3'd2: O = I2; 
      3'd3: O = I3; 
      3'd4: O = I4; 
      3'd5: O = I5; 
      3'd6: O = I6; 
      3'd7: O = I7; 
      default: O = SIZE; 
    endcase
  end
endmodule