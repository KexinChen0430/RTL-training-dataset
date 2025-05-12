module relay_mode (
	clk, 
	data_in, 
	data_in_available, 
	hi_simulate_mod_type, 
	mod_type, 
	data_out 
);
	input clk, data_in_available; 
	input [3:0] data_in; 
	input [2:0] hi_simulate_mod_type; 
	output [2:0] mod_type; 
	output data_out; 
	reg [2:0] mod_type = 3'b0; 
	wire [0:0] data_out; 
	reg [3:0] div_counter = 4'b0; 
	reg [19:0] receive_buffer = 20'b0; 
	reg [0:0] half_byte_counter = 1'b0; 
	assign data_out = receive_buffer[3]; 
	always @(posedge clk)
	begin
		div_counter <= div_counter + 1; 
		if (div_counter[3:0] == 4'b1000 && (hi_simulate_mod_type == `FAKE_READER || hi_simulate_mod_type == `FAKE_TAG))
			receive_buffer = {receive_buffer[18:0], 1'b0}; 
		if (hi_simulate_mod_type == `FAKE_READER && mod_type == 3'b0)
			mod_type = `READER_LISTEN;
		else if (hi_simulate_mod_type == `FAKE_TAG && mod_type == 3'b0)
			mod_type = `TAGSIM_LISTEN;
		if (data_in_available == 1'b1 && (hi_simulate_mod_type == `FAKE_READER || hi_simulate_mod_type == `FAKE_TAG)) begin
			receive_buffer[3:0] = data_in; 
			half_byte_counter = half_byte_counter + 1; 
			if (hi_simulate_mod_type == `FAKE_READER) 
			begin
				if (receive_buffer[19:0] == {16'b0, `READER_START_COMM_FIRST_CHAR})
				begin
					mod_type = `READER_MOD; 
					half_byte_counter = 1'b0; 
				end
				else if ((receive_buffer[19:0] == {`READER_END_COMM_1, 4'b0} || receive_buffer[19:0] == {`READER_END_COMM_2, 4'b0}) && half_byte_counter == 1'd0)
				begin
					mod_type = `READER_LISTEN; 
				end
			end
			else if (hi_simulate_mod_type == `FAKE_TAG) 
			begin
				if (receive_buffer[19:0] == {16'b0, `TAG_START_COMM_FIRST_CHAR})
				begin
					mod_type = `TAGSIM_MOD; 
					half_byte_counter = 1'b0; 
				end
				else if (receive_buffer[11:0] == {`TAG_END_COMM, 4'b0}  && half_byte_counter == 1'd0)
				begin
					mod_type = `TAGSIM_LISTEN; 
				end
			end
		end
	end
endmodule