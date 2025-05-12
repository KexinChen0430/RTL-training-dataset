module dsi_crc_comb (
    input [15:0] crc,    
    input [7:0] x,       
    output [15:0] crc_new 
);
    assign crc_new[0] = crc[8] ^ crc[12] ^ x[7] ^ x[3];
    assign crc_new[1] = crc[9] ^ crc[13] ^ x[6] ^ x[2];
    assign crc_new[2] = crc[10] ^ crc[14] ^ x[5] ^ x[1];
    assign crc_new[3] = crc[11] ^ crc[15] ^ x[4] ^ x[0];
    assign crc_new[4] = crc[12] ^ x[3];
    assign crc_new[5] = crc[8] ^ crc[12] ^ crc[13] ^ x[7] ^ x[3] ^ x[2];
    assign crc_new[6] = crc[9] ^ crc[13] ^ crc[14] ^ x[6] ^ x[2] ^ x[1];
    assign crc_new[7] = crc[10] ^ crc[14] ^ crc[15] ^ x[5] ^ x[1] ^ x[0];
    assign crc_new[8] = crc[0] ^ crc[11] ^ crc[15] ^ x[4] ^ x[0];
    assign crc_new[9] = crc[1] ^ crc[12] ^ x[3];
    assign crc_new[10] = crc[2] ^ crc[13] ^ x[2];
    assign crc_new[11] = crc[3] ^ crc[14] ^ x[1];
    assign crc_new[12] = crc[4] ^ crc[8] ^ crc[12] ^ crc[15] ^ x[7] ^ x[3] ^ x[0];
    assign crc_new[13] = crc[5] ^ crc[9] ^ crc[13] ^ x[6] ^ x[2];
    assign crc_new[14] = crc[6] ^ crc[10] ^ crc[14] ^ x[5] ^ x[1];
    assign crc_new[15] = crc[7] ^ crc[11] ^ crc[15] ^ x[4] ^ x[0];
endmodule