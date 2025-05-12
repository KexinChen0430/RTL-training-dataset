module MUXFULLPARALELL_4SEL_GENERIC # ( parameter SIZE=`WIDTH ) 
 (
 input wire [3:0] Sel, 
 input wire [SIZE-1:0] I0, I1, I2, I3,I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, 
 output reg [SIZE-1:0] O 
 );
always @( * ) 
  begin
    case (Sel) 
      4'd0: O = I0; 
      4'd1: O = I1; 
	  4'd2: O = I2; 
	  4'd3: O = I3; 
	  4'd4: O = I4; 
	  4'd5: O = I5; 
	  4'd6: O = I6; 
	  4'd7: O = I7; 
	  4'd8: O = I8; 
	  4'd9: O = I9; 
	  4'd10: O = I10; 
	  4'd11: O = I11; 
	  4'd12: O = I12; 
	  4'd13: O = I13; 
	  4'd14: O = I14; 
	  4'd15: O = I15; 
	  default: O = SIZE; 
    endcase
  end
endmodule