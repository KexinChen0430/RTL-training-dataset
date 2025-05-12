module pdp1_sbs16(i_clk, i_rst,
		  sb_ireq1, sb_ireq2, sb_ireq3, sb_ireq4, sb_dne,
		  pb_att, pb_op);
   input i_clk; 
   input i_rst; 
   output sb_ireq1; 
   output sb_ireq2; 
   output sb_ireq3; 
   output sb_ireq4; 
   input  sb_dne; 
   input  pb_att; 
   input [0:11] pb_op; 
   wire [0:5] 	w_ch; 
   wire [0:5] 	w_op; 
   assign w_ch = pb_op[0:5]; 
   assign w_op = pb_op[6:11]; 
   reg [0:15] 	r_enable; 
   reg [0:15] 	r_trig; 
   always @(posedge i_clk) begin
      if(i_rst) begin
	 r_enable <= 16'h0000; 
	 r_trig   <= 16'h0000; 
      end
      else begin
	 if(pb_att) begin
	    case(w_op)
	      `PDP1_SBS16_DSC:
		r_enable[w_ch] <= 1'b1; 
	      `PDP1_SBS16_ASC:
		r_enable[w_ch] <= 1'b0; 
	      `PDP1_SBS16_ISB:
		r_trig[w_ch] <= 1'b1; 
	      `PDP1_SBS16_CAC:
		r_enable <= 16'h0000; 
	    endcase 
	 end
      end
   end
endmodule 