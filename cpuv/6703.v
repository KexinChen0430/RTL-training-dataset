module core_interrupt_manager(
		input wire iCLOCK,
		input wire inRESET,
		input wire iFREE_IRQ_SETCONDITION,
		input wire iICT_VALID,
		input wire [5:0] iICT_ENTRY,
		input wire iICT_CONF_MASK,
		input wire iICT_CONF_VALID,
		input wire [1:0] iICT_CONF_LEVEL,
		input wire [31:0] iSYSREGINFO_PSR,
		input wire iEXT_ACTIVE,
		input wire [5:0] iEXT_NUM,
		output wire oEXT_ACK,
		input wire iFAULT_ACTIVE,
		input wire [6:0] iFAULT_NUM,
		input wire [31:0] iFAULT_FI0R,
		input wire iEXCEPTION_LOCK,
		output wire oEXCEPTION_ACTIVE,
		output wire [6:0] oEXCEPTION_IRQ_NUM,
		output wire [31:0] oEXCEPTION_IRQ_FI0R,
		input wire iEXCEPTION_IRQ_ACK
	);
	localparam STT_IDLE = 2'h0;
	localparam STT_COMP_WAIT = 2'h1;
	 && iFAULT_ACTIVE;
	assign hardware_interrupt_valid = !iEXCEPTION_LOCK && iEXT_ACTIVE && (!ict_conf_valid[iEXT_NUM] || (ict_conf_valid[iEXT_NUM] && ict_conf_mask[iEXT_NUM]));
	reg b_hw_irq_valid;
	reg [6:0] b_hw_irq_num;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_hw_irq_valid <= 1'b0;
			b_hw_irq_num <= 7'h0;
		end
		else begin
			if(!b_hw_irq_valid)begin
				if(iEXT_ACTIVE && (!ict_conf_valid[iEXT_NUM] || (ict_conf_valid[iEXT_NUM] && ict_conf_mask[iEXT_NUM])))begin
					b_hw_irq_valid <= 1'b1;
					b_hw_irq_num <= {1'b0, iEXT_NUM};
				end
			end
			else begin
				if(!software_interrupt_valid && b_state == STT_IDLE && !iEXCEPTION_LOCK)begin
					b_hw_irq_valid <= 1'b0;
				end
			end
		end
	end
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_state <= STT_IDLE;
			b_irq_num <= {7{1'b0}};
			b_irq_fi0r <= 32'h0;
			b_irq_type <= 1'b0;
			b_irq_ack <= 1'b0;
		end
		else begin
			case(b_state)
				STT_IDLE :
					begin
						if(software_interrupt_valid)begin
							b_state <= STT_COMP_WAIT;
							b_irq_num <= iFAULT_NUM;
							b_irq_fi0r <= iFAULT_FI0R;
							b_irq_type <= 1'b0;
							b_irq_ack <= 1'b1;
						end
						else if(b_hw_irq_valid && !iEXCEPTION_LOCK)begin
							b_state <= STT_COMP_WAIT;
							b_irq_num <= b_hw_irq_num;
							b_irq_fi0r <= 32'h0;
							b_irq_type <= 1'b1;
							b_irq_ack <= 1'b1;
						end
					end
				STT_COMP_WAIT :
					begin
						b_irq_ack <= 1'b0;
						if(iEXCEPTION_IRQ_ACK)begin
							b_state <= STT_IDLE;
						end
					end
				default :
					begin
						b_state <= STT_IDLE;
					end
			endcase
		end
	end
	assign oEXT_ACK = b_irq_ack && b_irq_type;
	assign oEXCEPTION_ACTIVE = (b_state == STT_COMP_WAIT)? !iEXCEPTION_IRQ_ACK : software_interrupt_valid || hardware_interrupt_valid || b_hw_irq_valid;
	assign oEXCEPTION_IRQ_NUM = (b_state == STT_COMP_WAIT)? b_irq_num : ((software_interrupt_valid)? iFAULT_NUM : {1'b0, iEXT_NUM});
	assign oEXCEPTION_IRQ_FI0R = b_irq_fi0r;
endmodule