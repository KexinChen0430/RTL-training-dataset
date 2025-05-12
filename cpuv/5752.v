module enable 
reg linkBIM; 
reg capture_rst; 
#{REG_TEXT} 
#{ASSIGN_TEXT} 
#{IP_TEXT} 
reg flag_reg; 
always @ (negedge bps_start or negedge rst_n) 
begin
	if (!rst_n) 
		flag_reg <= 1'b0; 
	else if (!bps_start) 
		flag_reg <= ~flag_reg; 
end
assign Flag = flag_reg; 
always @ (posedge clk or negedge rst_n) 
begin
	if (!rst_n) 
		Current <= IDLE; 
	else
		Current <= Next; 
end
always @ (*) 
begin
	Next = IDLE; 
	case (Current) 
		IDLE: 
			if (rx_data == 8'h24) 
				Next = S1; 
			else
				Next = IDLE; 
		S1: 
			if (Flag_temp != Flag) 
			begin
				if (rx_data != 8'h0d) 
					Next = S1; 
				else
					Next = SAVE; 
			end
			else
				Next = WAIT; 
		WAIT: 
			if (Flag_temp!=Flag) 
			begin
				if (rx_data != 8'h0d) 
					Next = S1; 
				else
					Next = SAVE; 
			end
			else
				Next = WAIT; 
		default: Next = IDLE; 
	endcase
end
always @ (posedge clk or negedge rst_n) 
begin
	if (!rst_n) 
	begin
		Flag_temp <= 1'b0; 
	end
	else
	begin
		Flag_temp <= Flag; 
	end
end
always @ (posedge clk or negedge rst_n) 
begin
	if(!rst_n) 
	begin
		Buff_temp <= `Buff_size'b0; 
		Rx_cmd <= `Buff_size'b0; 
		cmd_red <= 1'b0; 
	end
	else
	begin
		case (Current) 
			IDLE: 
			begin
				Buff_temp <= `Buff_size'b0; 
			end
			S1: 
			begin
				cmd_red <= 1'b1; 
				Buff_temp <= {{Buff_temp[`Buff_size - 9 : 0]}, rx_data}; 
			end
			WAIT: 
			begin
				Buff_temp <= Buff_temp; 
			end
			SAVE: 
			begin
				Rx_cmd  <= Buff_temp[`Buff_size - 9 : 0]; 
				Buff_temp <= `Buff_size'b0; 
				cmd_red <= 1'b0; 
			end
			default: 
			begin
			end
		endcase
	end
end
always @ (posedge clk or negedge rst_n) 
begin
  if(!rst_n) 
  begin
#{INIT_REG_TEXT} 
    led <= 1'b0; 
    linkBIM <= 1'b1; 
  end
  else if(cmd_red) begin 
			#{RST_REG_TEXT} 
            led <= 1'b0; 
            capture_rst <= 1'b0; 
  end
  else 
  begin
    case(Rx_cmd) 
      #{CMD_CASE_TEXT} 
      {R,S,T}: 
         begin
           #{RST_REG_TEXT} 
            led <= 1'b0; 
            linkBIM <= 1'b1; 
            capture_rst <= 1'b0; 
        end
         default: 
         begin
          #{DFT_REG_TEXT} 
          led <= 1'b0; 
          linkBIM <= 1'b1; 
          capture_rst <= 1'b0; 
      end
    endcase
  end
end
endmodule 