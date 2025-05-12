
module adbg_crc32(clk,data,enable,shift,clr,rst,crc_out,serial_out);

  input  clk;
  input  data;
  input  enable;
  input  shift;
  input  clr;
  input  rst;
  output [31:0] crc_out;
  output serial_out;
  reg  [31:0] crc;
  wire [31:0] new_crc;

  assign new_crc[0] = crc[1];
  assign new_crc[1] = crc[2];
  assign new_crc[2] = crc[3];
  assign new_crc[3] = crc[4];
  assign new_crc[4] = crc[5];
  assign new_crc[5] = ((((~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]) & ((~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]) & (~crc[0] & crc[6]))) & ~((~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]) & (((data & (~data | ~crc[0])) & ~crc[0]) & (~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0])))) | (~((~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]) & ((~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]) & (~crc[0] & crc[6]))) & ((~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]) & (((data & (~data | ~crc[0])) & ~crc[0]) & (~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) | ~crc[0]))))) | (~((data & ~crc[6]) | ((~data | ~crc[6]) & crc[6])) & crc[0]);
  assign new_crc[6] = crc[7];
  assign new_crc[7] = crc[8];
  assign new_crc[8] = ((~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) & crc[0]) | ((((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & (crc[9] & ~crc[0])))) & (((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9]))) & ~(((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((data & (~data | ~crc[0])) & ~crc[0])))) & (((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9]))))) | (~(((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & (crc[9] & ~crc[0])))) & (((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9]))) & (((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9])) & ((data & (~data | ~crc[0])) & ~crc[0])))) & (((((~crc[0] & (~crc[9] | ~data)) & (~data & crc[9])) | (data & (~crc[0] & (~crc[9] | ~data)))) | (~((crc[9] | (~crc[9] & data)) & (~crc[9] | ~data)) | (data & (~crc[9] & ~crc[0])))) | ((~data & ~crc[0]) & crc[9]))));
  assign new_crc[9] = ((~((((data | ~data) & (crc[10] | data)) & ~crc[10]) | ((crc[10] & (~data | ~crc[10])) & ~data)) & crc[0]) | ((data | ~data) & (crc[10] | data))) & ((~((((data | ~data) & (crc[10] | data)) & ~crc[10]) | ((crc[10] & (~data | ~crc[10])) & ~data)) & crc[0]) | ((~crc[0] & ~crc[10]) | (((crc[10] & (~data | ~crc[10])) & ~data) & ~crc[0])));
  assign new_crc[10] = crc[11];
  assign new_crc[11] = crc[12];
  assign new_crc[12] = crc[13];
  assign new_crc[13] = crc[14];
  assign new_crc[14] = crc[15];
  assign new_crc[15] = crc[0] ^ ((crc[16] & (~crc[16] | ~data)) | (~crc[16] & data));
  assign new_crc[16] = crc[17];
  assign new_crc[17] = crc[18];
  assign new_crc[18] = crc[19];
  assign new_crc[19] = crc[0] ^ (((crc[20] & ~data) | data) & (~crc[20] | (crc[20] & ~data)));
  assign new_crc[20] = ((~crc[21] & ((data & (~data | ~crc[0])) & ~crc[0])) | (~((~crc[21] & data) | ((~data | ~crc[21]) & crc[21])) & crc[0])) | ((~data & ~crc[0]) & crc[21]);
  assign new_crc[21] = (crc[22] ^ data) ^ crc[0];
  assign new_crc[22] = crc[23];
  assign new_crc[23] = (crc[0] & ~(((crc[24] & (~crc[24] | ~data)) & ~data) | (~crc[24] & data))) | (((~((data & (~data | ~crc[0])) & ~crc[0]) & ~crc[0]) & crc[24]) | ((~crc[0] & ~(~crc[0] & crc[24])) & data));
  assign new_crc[24] = (~(crc[25] ^ data) & crc[0]) | ((crc[25] & (~((data & (~data | ~crc[0])) & ~crc[0]) & ~crc[0])) | ((~(~crc[0] & crc[25]) & ~crc[0]) & data));
  assign new_crc[25] = crc[26];
  assign new_crc[26] = (((data & ~crc[27]) | crc[27]) & ((~data | ~crc[27]) & ~crc[0])) | (~((crc[27] & ~data) | (data & ~crc[27])) & crc[0]);
  assign new_crc[27] = crc[0] ^ ((data & ~crc[28]) | (~data & crc[28]));
  assign new_crc[28] = crc[29];
  assign new_crc[29] = ((crc[0] & ~(((data | crc[30]) & (data | ~data)) & (~crc[30] | (~data & crc[30])))) | (((data | crc[30]) & (data | ~data)) & (~crc[30] | (~data & crc[30])))) & (~crc[0] | ~(((data | crc[30]) & (data | ~data)) & (~crc[30] | (~data & crc[30]))));
  assign new_crc[30] = (crc[0] & ~((~crc[31] | (~data & crc[31])) & ((data & ~crc[31]) | crc[31]))) | (((~crc[31] | (~data & crc[31])) & ((data & ~crc[31]) | crc[31])) & ~crc[0]);
  assign new_crc[31] = crc[0] ^ data;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) crc[31:0] <= 32'hffffffff;
        else if (clr) crc[31:0] <= 32'hffffffff;
        else if (enable) crc[31:0] <= new_crc;
        else if (shift) crc[31:0] <= {1'b0,crc[31:1]};
          
      end
  assign crc_out = crc;
  assign serial_out = crc[0];
endmodule

