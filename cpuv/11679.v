module can get it 
	if(current_cpuid_valid==1'b0) begin 
		out_input_valid<=1'b0; 
	end
	else begin 
		out_input_valid<=1'b1; 
	end
	current_state <= wait_s; 
end
end
wait_s: begin 
	if(in_input_ctl==1'b1) begin 
		out_input_ack<=1'b1; 
		current_state <= wait_s; 
	end
	else begin 
		out_input_ack<=1'b0; 
		current_state <= idle_s; 
	end
end
default: begin 
	out_input_ack<=1'b0; 
	out_input_cpuid<=5'b0; 
	cpuid_reg<=5'b0; 
	current_state <= idle_s; 
end
endcase 
end 
endmodule 