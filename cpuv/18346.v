module crc_calculator 
)(
	output [CRC_SIZE - 1 : 0] crc_out,   
	input                    data_in,    
	input [CRC_SIZE - 1 : 0] crc_in,     
	input [CRC_SIZE - 1 : 0] crc_poly,   
    input [CRC_SIZE - 2 : 0] crc_poly_size 
);
wire [CRC_SIZE - 2 : 0] MASK_REVERSED; 
wire [CRC_SIZE - 1 : 0] feedback; 
wire [CRC_SIZE - 2 : 0] crc_in_masked; 
wire [CRC_SIZE - 2 : 0] crc_poly_size_reversed; 
generate
  genvar i;
  for(i = 0; i < CRC_SIZE - 1; i = i + 1) 
    begin
			assign crc_poly_size_reversed[i] = crc_poly_size[CRC_SIZE - 2 - i]; 
   		assign MASK_REVERSED[i] = MASK[CRC_SIZE - 2 - i]; 
		end
endgenerate
assign feedback = crc_poly & {CRC_SIZE{crc_in[CRC_SIZE - 1] ^ data_in}};
assign crc_in_masked = crc_in[CRC_SIZE - 2 : 0] & (~(crc_poly_size_reversed[CRC_SIZE - 2 : 0] & MASK_REVERSED));
assign crc_out = {crc_in_masked ^ feedback[CRC_SIZE - 1 : 1], feedback[0]};
endmodule