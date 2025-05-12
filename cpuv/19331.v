module MUXFULLPARALELL_2SEL_GENERIC # ( parameter SIZE=`WIDTH ) 
(
    input wire [1:0] Sel, 
    input wire [SIZE-1:0] I0, I1, I2, I3, 
    output reg [SIZE-1:0] O 
);
always @( * )
  begin
    case (Sel) 
      2'b00: O = I0; 
      2'b01: O = I1; 
      2'b10: O = I2; 
      2'b11: O = I3; 
      default: O = SIZE; 
    endcase 
  end
endmodule 