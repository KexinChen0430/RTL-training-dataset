module MUXFULLPARALELL_5SEL_GENERIC # ( parameter SIZE=`WIDTH ) 
(
    input wire [4:0] Sel, 
    input wire [SIZE-1:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15,
    input wire [SIZE-1:0] I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31,
    output reg [SIZE-1:0] O 
);
always @( * )
  begin
    case (Sel) 
      5'd0: O = I0;
      5'd1: O = I1;
      5'd2: O = I2;
      5'd3: O = I3;
      5'd4: O = I4;
      5'd5: O = I5;
      5'd6: O = I6;
      5'd7: O = I7;
      5'd8: O = I8;
      5'd9: O = I9;
      5'd10: O = I10;
      5'd11: O = I11;
      5'd12: O = I12;
      5'd13: O = I13;
      5'd14: O = I14;
      5'd15: O = I15;
      5'd16: O = I16;
      5'd17: O = I17;
      5'd18: O = I18;
      5'd19: O = I19;
      5'd20: O = I20;
      5'd21: O = I21;
      5'd22: O = I22;
      5'd23: O = I23;
      5'd24: O = I24;
      5'd25: O = I25;
      5'd26: O = I26;
      5'd27: O = I27;
      5'd28: O = I28;
      5'd29: O = I29;
      5'd30: O = I30;
      5'd31: O = I31;
      default: O = SIZE; 
    endcase
  end
endmodule