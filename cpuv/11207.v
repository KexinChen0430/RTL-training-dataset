module iobdg_asi_dec ( 
   asi_ctrl, asi_addr, 
   ucb_packet 
   );
   input [`UCB_64PAY_PKT_WIDTH-1:0]    ucb_packet; 
   output [31:0] 		       asi_ctrl; 
   output [31:0] 		       asi_addr; 
   reg [31:0] 			       asi_ctrl; 
   wire [`UCB_ADDR_WIDTH-1:0] 	       ucb_packet_addr; 
   assign 	 ucb_packet_addr = ucb_packet[`UCB_ADDR_HI:`UCB_ADDR_LO]; 
   always @(ucb_packet_addr) begin 
      case (ucb_packet_addr[39:28]) 
	{`CPU_ASI,`IOB_ASI_L1ID}:begin 
	   asi_ctrl = {30'b0100000,ucb_packet_addr[24:23]}; 
	end
	{`CPU_ASI,`IOB_ASI_L1DD}:begin 
	   asi_ctrl = {30'b0010000,ucb_packet_addr[24:23]}; 
	end
	{`CPU_ASI,`IOB_ASI_BIST}:begin 
	   asi_ctrl = {30'b0001000,ucb_packet_addr[24:23]}; 
	end
	{`CPU_ASI,`IOB_ASI_MARGIN}:begin 
	   asi_ctrl = {30'b0000100,ucb_packet_addr[24:23]}; 
	end
	{`CPU_ASI,`IOB_ASI_DEFEATURE}:begin 
	   asi_ctrl = {30'b0000010,ucb_packet_addr[24:23]}; 
	end
	{`CPU_ASI,`IOB_ASI_PC}:begin 
	   asi_ctrl = {30'b0000001,ucb_packet_addr[24:23]}; 
	end
	default:begin 
	   asi_ctrl = 32'b0; 
	end
      endcase 
   end 
   assign        asi_addr = {9'b0,ucb_packet_addr[22:0]}; 
endmodule 