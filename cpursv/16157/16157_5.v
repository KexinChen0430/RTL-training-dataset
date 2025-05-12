
module dbg_crc32_d1(data,enable,shift,rst,sync_rst,crc_out,clk,crc_match);

  input  data;
  input  enable;
  input  shift;
  input  rst;
  input  sync_rst;
  input  clk;
  output crc_out;
  output crc_match;
  reg  [31:0] crc;
  wire [31:0] new_crc;

  assign new_crc[0] = (~crc[31] | ~data) & ((~crc[31] & data) | crc[31]);
  assign new_crc[1] = (((crc[31] | ~crc[31]) & ((data | crc[0]) & (~data | (~crc[0] & (~data | data))))) & ~((crc[31] | ~crc[31]) & (crc[31] & ((data | crc[0]) | ~((data | crc[0]) & (~data | (~crc[0] & (~data | data)))))))) | (~((crc[31] | ~crc[31]) & ((data | crc[0]) & (~data | (~crc[0] & (~data | data))))) & ((crc[31] | ~crc[31]) & (crc[31] & ((data | crc[0]) | ~((data | crc[0]) & (~data | (~crc[0] & (~data | data))))))));
  assign new_crc[2] = (((((((((crc[31] & ~((((~crc[1] | crc[1]) & data) & ~crc[1]) | (crc[1] & ~((~crc[1] | crc[1]) & data)))) | ~crc[1]) & ((crc[31] & ~((((~crc[1] | crc[1]) & data) & ~crc[1]) | (crc[1] & ~((~crc[1] | crc[1]) & data)))) | data)) | (~data & (crc[1] | data))) & ~((((~crc[1] | crc[1]) & data) & ~crc[1]) | (crc[1] & ~((~crc[1] | crc[1]) & data)))) | ~crc[31]) & (~crc[31] & data)) & ~(crc[1] & ~crc[31])) | (crc[31] & ~((((~crc[1] | crc[1]) & data) & ~crc[1]) | (crc[1] & ~((~crc[1] | crc[1]) & data))))) | ((crc[1] & ~crc[31]) & ~(~crc[31] & data));
  assign new_crc[3] = crc[2];
  assign new_crc[31] = crc[30];
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) crc[31:0] <= 32'hffffffff;
        else if (sync_rst) crc[31:0] <= 32'hffffffff;
        else if (enable) crc[31:0] <= new_crc;
        else if (shift) crc[31:0] <= {crc[30:0],1'b0};
          
      end
  assign crc_match = crc == 32'h0;
  assign crc_out = crc[31];
endmodule

