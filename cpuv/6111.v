module rr_mux4
  (
   input 		clock,
   input 		reset,
   input [3:0] 		rri_valid,
   output [3:0] 	rri_ready,
   input [63:0] 	rri_addr_0,
   input [63:0] 	rri_addr_1,
   input [63:0] 	rri_addr_2,
   input [63:0] 	rri_addr_3,
   input [TAG-1:0] 	rri_tag_0,
   input [TAG-1:0] 	rri_tag_1,
   input [TAG-1:0] 	rri_tag_2,
   input [TAG-1:0] 	rri_tag_3,
   output reg 		rro_valid = 0,
   input 		rro_ready,
   output [63:0] 	rro_addr,
   output reg [TAG-1:0] rro_tag
   );
   parameter TAG = 8;
   parameter AMIN = 0; 
   reg [3:0] 		state = 0;
   reg [63-AMIN:0] 	rro_addr_s;
   assign rro_addr[63:AMIN] = rro_addr_s;
   assign rro_addr[AMIN-1:0] = 0;
   always @ (posedge clock)
     begin
	if(reset)
	  state <= 4'h0;
	else
	  begin
	     casex(state)
	       4'h0: state <= state + (rri_valid[0] ? 4'd1 : 4'd4);
	       4'h4: state <= state + (rri_valid[1] ? 4'd1 : 4'd4);
	       4'h8: state <= state + (rri_valid[2] ? 4'd1 : 4'd4);
	       4'hC: state <= state + (rri_valid[3] ? 4'd1 : 4'd4);
	       4'bxx01: state <= state + rro_ready;
	       default: state <= state + 1'b1;
	     endcase
	  end
	rro_valid <= (state[1:0] == 1) && ~rro_ready;
	case(state[3:2])
	  0: rro_addr_s <= rri_addr_0[63:AMIN];
	  1: rro_addr_s <= rri_addr_1[63:AMIN];
	  2: rro_addr_s <= rri_addr_2[63:AMIN];
	  3: rro_addr_s <= rri_addr_3[63:AMIN];
	endcase
	case(state[3:2])
	  0: rro_tag <= rri_tag_0;
	  1: rro_tag <= rri_tag_1;
	  2: rro_tag <= rri_tag_2;
	  3: rro_tag <= rri_tag_3;
	endcase
     end
   assign rri_ready[0] = state == 2;
   assign rri_ready[1] = state == 6;
   assign rri_ready[2] = state == 10;
   assign rri_ready[3] = state == 14;
endmodule