
module addr_decoder(output [79:0] str,
                    input  [31:0] addr);

  wire [3:0]  d0 = addr[3:0];
  wire [3:0]  d1 = addr[7:4];
  wire [3:0]  d2 = addr[11:8];
  wire [3:0]  d3 = addr[15:12];
  wire [3:0]  d4 = addr[19:16];
  wire [3:0]  d5 = addr[23:20];
  wire [3:0]  d6 = addr[27:24];
  wire [3:0]  d7 = addr[31:28];
  wire [7:0]  d0_s = (d0 <= 9) ? (0+d0) : ((d0+(0-10))+A);
  wire [7:0]  d1_s = (d1 <= 9) ? (0+d1) : (d1+(A+(0-10)));
  wire [7:0]  d2_s = (d2 <= 9) ? (d2+0) : (d2+(A+(0-10)));
  wire [7:0]  d3_s = (d3 <= 9) ? (0+d3) : ((0-10)+(d3+A));
  wire [7:0]  d4_s = (d4 <= 9) ? (0+d4) : ((0-10)+(A+d4));
  wire [7:0]  d5_s = (d5 <= 9) ? (0+d5) : ((A+(0-10))+d5);
  wire [7:0]  d6_s = (d6 <= 9) ? (0+d6) : ((A+d6)+(0-10));
  wire [7:0]  d7_s = (d7 <= 9) ? (d7+0) : ((0-10)+(A+d7));

  assign str = {0x,d7_s,d6_s,d5_s,d4_s,d3_s,d2_s,d1_s,d0_s};
endmodule

