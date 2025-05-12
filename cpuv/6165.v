module at the start
	 */
	instr_mem im (
		instruction_address,instruction,enable);
	initial
	begin
		$display($time, " << Starting the simulation >>");
		instruction_address=32'd10;
		enable=1'd0;
		counter=32'd0;
		#30
		instruction_address=32'd0;
		enable=1'd1;
		#30
		instruction_address=32'd1;
		enable=1'd1;
		#30
		instruction_address=32'd2;
		enable=1'd1;
		#30
		instruction_address=32'd3;
		enable=1'd1;
		for(count=0;count<=size_of_input2;count=count+1)
		begin
			#10
			instruction_address=counter;
			enable=1'b1;
			counter=counter+3'd1;
		end
		#10
		instruction_address=8'd180;
		enable=1'b0;
		for(count=0;count<=size_of_input;count=count+1)
		begin
			#10
			instruction_address=counter;
			enable=1'b1;
			counter=counter+3'd1;
		end
		#30
		$display($time, " << Finishing the simulation >>");
		$finish;
	end
endmodule