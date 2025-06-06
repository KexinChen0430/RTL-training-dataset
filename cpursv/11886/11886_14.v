
module dec_4_to_16(input  [3:0] ADDR,
                   output [15:0] DEC);

  assign DEC[0] = ((~ADDR[1] & ~ADDR[0]) & ~ADDR[3]) & ~ADDR[2];
  assign DEC[1] = ~ADDR[0] & ((~ADDR[2] & ~ADDR[1]) & ADDR[3]);
  assign DEC[2] = (~ADDR[0] & (~ADDR[1] & ADDR[2])) & ~ADDR[3];
  assign DEC[3] = (ADDR[3] & (~ADDR[1] & ADDR[2])) & ~ADDR[0];
  assign DEC[4] = (~ADDR[2] & ~ADDR[3]) & (~ADDR[0] & ADDR[1]);
  assign DEC[5] = ~ADDR[0] & (ADDR[3] & (ADDR[1] & ~ADDR[2]));
  assign DEC[6] = ~ADDR[0] & ((ADDR[2] & ~ADDR[3]) & ADDR[1]);
  assign DEC[7] = ((ADDR[2] & ADDR[3]) & ~ADDR[0]) & ADDR[1];
  assign DEC[8] = (~ADDR[3] & ~ADDR[1]) & (~ADDR[2] & ADDR[0]);
  assign DEC[9] = ((~ADDR[2] & ~ADDR[1]) & ADDR[3]) & ADDR[0];
  assign DEC[10] = ~ADDR[1] & (ADDR[2] & (ADDR[0] & ~ADDR[3]));
  assign DEC[11] = (~ADDR[1] & ADDR[2]) & (ADDR[0] & ADDR[3]);
  assign DEC[12] = (~ADDR[2] & ~ADDR[3]) & (ADDR[0] & ADDR[1]);
  assign DEC[13] = ((ADDR[0] & ADDR[1]) & ~ADDR[2]) & ADDR[3];
  assign DEC[14] = (ADDR[2] & (ADDR[0] & ~ADDR[3])) & ADDR[1];
  assign DEC[15] = (ADDR[1] & ADDR[2]) & (ADDR[0] & ADDR[3]);
endmodule

