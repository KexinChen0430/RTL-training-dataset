module seven_seg_decoder(led_out,bin_in); 
seven_seg_decoder ssd(hex_pins,current_count); 
initial
    begin
	     state <= main_go; 
		  sleep <= 6; 
	 end
always @(posedge clk) 
    begin
	     case(state) 
		      main_go: 
				    begin
				        main_lights <= 5'b00100; 
					     cross_lights <= 5'b10000; 
				    end
		  endcase
	 end
always @(posedge clk) 
    begin
    end 
endmodule 