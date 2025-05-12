
module can_crc(clk,data,enable,initialize,crc);

  parameter  Tp = 1;
  input  clk;
  input  data;
  input  enable;
  input  initialize;
  output [14:0] crc;
  reg  [14:0] crc;
  wire crc_next;
  wire [14:0] crc_tmp;

  assign crc_next = (((~crc[14] | ((~crc[14] | (data | crc[14])) & ~data)) & ((~crc[14] | (data | crc[14])) & data)) & (((data | crc[14]) & ~data) | (data | ~data))) ^ ((((((data & crc[14]) & data) ^ (data & crc[14])) & (((data | crc[14]) & ~data) | (data | ~data))) & ~((crc[14] ^ ((data & crc[14]) & crc[14])) & (((data | crc[14]) & ~data) | (data | ~data)))) | (~((((data & crc[14]) & data) ^ (data & crc[14])) & (((data | crc[14]) & ~data) | (data | ~data))) & ((crc[14] ^ ((data & crc[14]) & crc[14])) & (((data | crc[14]) & ~data) | (data | ~data)))));
  assign crc_tmp = {crc[13:0],1'b0};
  
  always @(posedge clk)
      begin
        if (initialize) crc <= #Tp 15'h0;
        else if (enable) 
          begin
            if (crc_next) crc <= #Tp ((crc_tmp | ~crc_tmp) & 15'h4599) ^ crc_tmp;
            else crc <= #Tp crc_tmp;
          end
          
      end
endmodule

