module des_state
	(
	input		se_clk, 
	input		se_rstn, 
	input		go_sup, 
	input		line_3d_actv_15, 
	input		ns1_eqz, 
	input		ns2_eqz, 
	input		co_linear, 
	input		det_eqz, 
	input		cull, 
	output reg		sup_done, 
 	output reg		abort_cmd, 
	output reg	[5:0]	se_cstate 
	);
	`include "define_3d.h" 
	reg		go_sup_1; 
	reg		go_sup_2; 
  always @ (posedge se_clk or negedge se_rstn) begin 
	    if (!se_rstn) begin 
		    se_cstate <= 6'b000000; 
      		    sup_done  <= 1'b0; 
	      	    abort_cmd <= 1'b0; 
		    go_sup_1  <= 1'b0; 
		    go_sup_2  <= 1'b0; 
	    end
	    else begin 
		go_sup_2  <= go_sup_1; 
		go_sup_1  <= go_sup; 
	      	abort_cmd <= 1'b0; 
      		if((se_cstate == 6'b000000) & go_sup_2) se_cstate <= 6'b000001; 
		else if((se_cstate == `COLIN_STATE) & co_linear & ~line_3d_actv_15) begin 
	      		abort_cmd <= 1'b1; 
	      		se_cstate <= 6'b000000; 
	    	end
		else if((se_cstate == `NL1_NL2_STATE) & (ns1_eqz & ns2_eqz & ~line_3d_actv_15)) begin 
	      		abort_cmd <= 1'b1; 
	      		se_cstate <= 6'b000000; 
	    	end
		else if((se_cstate == `NO_AREA_STATE) & ((cull | det_eqz) & ~line_3d_actv_15)) begin 
	      		abort_cmd <= 1'b1; 
	      		se_cstate <= 6'b000000; 
	    	end
      		else if(se_cstate == 6'b000000) se_cstate <= 6'b000000; 
      		else if((se_cstate == `SETUP_END)) se_cstate <= 6'b000000; 
      		else se_cstate <= se_cstate + 6'b000001; 
      		sup_done <= (se_cstate == `SETUP_END); 
    	   end
   end
endmodule