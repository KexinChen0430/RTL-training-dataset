module CRC8_ATM(
	input wire clk, 
	input wire reset, 
	input wire update, 
	input wire[31:0] din, 
	output reg[7:0] crc = 0, 
	output reg[7:0] crc_first24 = 0 
);
	wire[23:0] din_first24 = din[31:8]; 
	reg[7:0] last_crc = 0; 
	always @(*) begin
		if(reset)
			last_crc	<= 8'h00; 
		else
			last_crc	<= crc; 
	end
	always @(posedge clk) begin
		if(update) begin
			crc[0] <= din[31] ^ din[30] ^ din[28] ^ din[23] ^ din[21] ^ din[19] ^ din[18] ^ din[16] ^ din[14] ^ din[12] ^ din[8] ^ din[7] ^ din[6] ^ din[0] ^ last_crc[4] ^ last_crc[6] ^ last_crc[7];
			crc[1] <= din[30] ^ din[29] ^ din[28] ^ din[24] ^ din[23] ^ din[22] ^ din[21] ^ din[20] ^ din[18] ^ din[17] ^ din[16] ^ din[15] ^ din[14] ^ din[13] ^ din[12] ^ din[9] ^ din[6] ^ din[1] ^ din[0] ^ last_crc[0] ^ last_crc[4] ^ last_crc[5] ^ last_crc[6];
			crc[2] <= din[29] ^ din[28] ^ din[25] ^ din[24] ^ din[22] ^ din[17] ^ din[15] ^ din[13] ^ din[12] ^ din[10] ^ din[8] ^ din[6] ^ din[2] ^ din[1] ^ din[0] ^ last_crc[0] ^ last_crc[1] ^ last_crc[4] ^ last_crc[5];
			crc[3] <= din[30] ^ din[29] ^ din[26] ^ din[25] ^ din[23] ^ din[18] ^ din[16] ^ din[14] ^ din[13] ^ din[11] ^ din[9] ^ din[7] ^ din[3] ^ din[2] ^ din[1] ^ last_crc[1] ^ last_crc[2] ^ last_crc[5] ^ last_crc[6];
			crc[4] <= din[31] ^ din[30] ^ din[27] ^ din[26] ^ din[24] ^ din[19] ^ din[17] ^ din[15] ^ din[14] ^ din[12] ^ din[10] ^ din[8] ^ din[4] ^ din[3] ^ din[2] ^ last_crc[0] ^ last_crc[2] ^ last_crc[3] ^ last_crc[6] ^ last_crc[7];
			crc[5] <= din[31] ^ din[28] ^ din[27] ^ din[25] ^ din[20] ^ din[18] ^ din[16] ^ din[15] ^ din[13] ^ din[11] ^ din[9] ^ din[5] ^ din[4] ^ din[3] ^ last_crc[1] ^ last_crc[3] ^ last_crc[4] ^ last_crc[7];
			crc[6] <= din[29] ^ din[28] ^ din[26] ^ din[21] ^ din[19] ^ din[17] ^ din[16] ^ din[14] ^ din[12] ^ din[10] ^ din[6] ^ din[5] ^ din[4] ^ last_crc[2] ^ last_crc[4] ^ last_crc[5];
			crc[7] <= din[30] ^ din[29] ^ din[27] ^ din[22] ^ din[20] ^ din[18] ^ din[17] ^ din[15] ^ din[13] ^ din[11] ^ din[7] ^ din[6] ^ din[5] ^ last_crc[3] ^ last_crc[5] ^ last_crc[6];
			crc_first24[0] <= din_first24[23] ^ din_first24[21] ^ din_first24[19] ^ din_first24[18] ^ din_first24[16] ^ din_first24[14] ^ din_first24[12] ^ din_first24[8] ^ din_first24[7] ^ din_first24[6] ^ din_first24[0] ^ last_crc[0] ^ last_crc[2] ^ last_crc[3] ^ last_crc[5] ^ last_crc[7];
			crc_first24[1] <= din_first24[23] ^ din_first24[22] ^ din_first24[21] ^ din_first24[20] ^ din_first24[18] ^ din_first24[17] ^ din_first24[16] ^ din_first24[15] ^ din_first24[14] ^ din_first24[13] ^ din_first24[12] ^ din_first24[9] ^ din_first24[6] ^ din_first24[1] ^ din_first24[0] ^ last_crc[0] ^ last_crc[1] ^ last_crc[2] ^ last_crc[4] ^ last_crc[5] ^ last_crc[6] ^ last_crc[7];
			crc_first24[2] <= din_first24[22] ^ din_first24[17] ^ din_first24[15] ^ din_first24[13] ^ din_first24[12] ^ din_first24[10] ^ din_first24[8] ^ din_first24[6] ^ din_first24[2] ^ din_first24[1] ^ din_first24[0] ^ last_crc[1] ^ last_crc[6];
			crc_first24[3] <= din_first24[23] ^ din_first24[18] ^ din_first24[16] ^ din_first24[14] ^ din_first24[13] ^ din_first24[11] ^ din_first24[9] ^ din_first24[7] ^ din_first24[3] ^ din_first24[2] ^ din_first24[1] ^ last_crc[0] ^ last_crc[2] ^ last_crc[7];
			crc_first24[4] <= din_first24[19] ^ din_first24[17] ^ din_first24[15] ^ din_first24[14] ^ din_first24[12] ^ din_first24[10] ^ din_first24[8] ^ din_first24[4] ^ din_first24[3] ^ din_first24[2] ^ last_crc[1] ^ last_crc[3];
			crc_first24[5] <= din_first24[20] ^ din_first24[18] ^ din_first24[16] ^ din_first24[15] ^ din_first24[13] ^ din_first24[11] ^ din_first24[9] ^ din_first24[5] ^ din_first24[4] ^ din_first24[3] ^ last_crc[0] ^ last_crc[2] ^ last_crc[4];
			crc_first24[6] <= din_first24[21] ^ din_first24[19] ^ din_first24[17] ^ din_first24[16] ^ din_first24[14] ^ din_first24[12] ^ din_first24[10] ^ din_first24[6] ^ din_first24[5] ^ din_first24[4] ^ last_crc[0] ^ last_crc[1] ^ last_crc[3] ^ last_crc[5];
			crc_first24[7] <= din_first24[22] ^ din_first24[20] ^ din_first24[18] ^ din_first24[17] ^ din_first24[15] ^ din_first24[13] ^ din_first24[11] ^ din_first24[7] ^ din_first24[6] ^ din_first24[5] ^ last_crc[1] ^ last_crc[2] ^ last_crc[4] ^ last_crc[6];
		end
		else if(reset)
			crc <= 'h00; 
	end
endmodule