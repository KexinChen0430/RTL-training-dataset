module select_vector(
		     input wire [`SPECTAG_LEN-1:0] spectag,
		     input wire [`REG_NUM-1:0] 	   dat0,
		     input wire [`REG_NUM-1:0] 	   dat1,
		     input wire [`REG_NUM-1:0] 	   dat2,
		     input wire [`REG_NUM-1:0] 	   dat3,
		     input wire [`REG_NUM-1:0] 	   dat4,
		     output reg [`REG_NUM-1:0] 	   out
		     );
   always @ (*) begin
      out = 0;
      case (spectag)
	5'b00001 : out = dat1;
	5'b00010 : out = dat2;
	5'b00100 : out = dat3;
	5'b01000 : out = dat4;
	5'b10000 : out = dat0;
	default : out = 0;
      endcase 
   end
endmodule