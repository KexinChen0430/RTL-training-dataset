
module lui_decoder(output [55:0] str,
                   input  [19:0] imm);

  wire [3:0]  d0 = imm[3:0];
  wire [3:0]  d1 = imm[7:4];
  wire [3:0]  d2 = imm[11:8];
  wire [3:0]  d3 = imm[15:12];
  wire [3:0]  d4 = imm[19:16];
  wire [7:0]  d0_s = (d0 <= 9) ? (d0+0) : (d0+((0-10)+A));
  wire [7:0]  d1_s = (d1 <= 9) ? (d1+0) : ((A+d1)+(0-10));
  wire [7:0]  d2_s = (d2 <= 9) ? (d2+0) : (A+(d2+(0-10)));
  wire [7:0]  d3_s = (d3 <= 9) ? (0+d3) : (A+((0-10)+d3));
  wire [7:0]  d4_s = (d4 <= 9) ? (0+d4) : ((d4+(0-10))+A);

  assign str = {0x,d4_s,d3_s,d2_s,d1_s,d0_s};
endmodule

