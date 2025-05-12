module edc_corrector (
input   [31:0]  i_data, 
input   [7:0]   i_syndrome, 
output  [31:0]  o_data, 
output          o_error_detected, 
output          o_uncorrected_error 
);
wire [7:0] decoder_matrix[0:39]; 
wire [39:0] error_vector; 
generate
	assign decoder_matrix[39]  = 8'b10101000;
	assign decoder_matrix[0]  = 8'b00000001;
endgenerate
genvar c;
generate
	for (c=0; c<40; c=c+1) begin
		assign error_vector[c] = decoder_matrix[c] == i_syndrome;
	end
endgenerate
assign o_error_detected = | i_syndrome; 
assign o_uncorrected_error = o_error_detected & (~| error_vector);
assign o_data = error_vector[39:8] ^ i_data;
endmodule