module pdp1_write_decoder(ma_op, ma_ac, ma_io, ma_cd, ma_w, ma_r);
   input [0:4] ma_op;
   input [0:17] ma_ac;
   input [0:17] ma_io;
   input [0:17] ma_cd;
   output reg	ma_w;
   output reg [0:17] ma_r;
   always @(ma_op or ma_ac or ma_io or ma_cd) begin
      ma_w = 1'b1;
      case(ma_op)
	`PDP1_OP_CAL:
	  ma_r <= ma_ac;
	`PDP1_OP_DAC:
	  ma_r <= ma_ac;
	`PDP1_OP_DAP:
	  ma_r <= {ma_cd[0:5], ma_ac[6:17]};
	`PDP1_OP_DIP:
	  ma_r <= {ma_ac[0:5], ma_cd[6:17]};
	`PDP1_OP_DIO:
	  ma_r <= ma_io;
	`PDP1_OP_DZM:
	  ma_r <= 0;
	default:
	  ma_w <= 0;
      endcase 
   end
endmodule