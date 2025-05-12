
module test(input  rst,
            input  clk,
            input  [19:0] inst_in,
            input  [3:0] flg_in,
            input  [15:0] sr_in,
            input  [15:0] a_src,
            input  [15:0] ea1b,
            input  [15:0] extw,
            output reg branch);

  
  always @(inst_in or flg_in or sr_in or a_src or ea1b or extw)
      begin
        case (inst_in[15:12])

          4'b0000: branch <= (inst_in[11] & ((~sr_in[12] & inst_in[11]) | ~inst_in[11])) ^ (sr_in[12] & ((~sr_in[12] & inst_in[11]) | ~inst_in[11]));

          4'b0001: branch <= (~inst_in[11] & ((flg_in[1] | ~flg_in[1]) & (inst_in[11] | flg_in[1]))) | (inst_in[11] & ~flg_in[1]);

          4'b0010: branch <= ((inst_in[11] | ~inst_in[11]) & ((inst_in[11] | ~inst_in[11]) & (flg_in[2] & (inst_in[11] | ~inst_in[11])))) ^ inst_in[11];

          4'b0011: branch <= (~flg_in[3] & inst_in[11]) | (~inst_in[11] & ((~flg_in[3] & (flg_in[3] | inst_in[11])) | flg_in[3]));

          4'b0100: branch <= (((a_src[0] & (inst_in[11] | ~inst_in[11])) & (~inst_in[11] | (~a_src[0] & (inst_in[11] | ~inst_in[11])))) & ~((inst_in[11] & (~inst_in[11] | (~a_src[0] & (inst_in[11] | ~inst_in[11])))) & (inst_in[11] | ~inst_in[11]))) | (((inst_in[11] & (~inst_in[11] | (~a_src[0] & (inst_in[11] | ~inst_in[11])))) & (inst_in[11] | ~inst_in[11])) & ~((a_src[0] & (inst_in[11] | ~inst_in[11])) & (~inst_in[11] | (~a_src[0] & (inst_in[11] | ~inst_in[11])))));

          4'b0101: branch <= ((inst_in[11] | ~inst_in[11]) & ea1b[4]) ^ inst_in[11];

          4'b0110: branch <= ((((inst_in[11] | ea1b[7]) & (ea1b[7] | ~ea1b[7])) & inst_in[11]) & ~ea1b[7]) | (ea1b[7] & ~inst_in[11]);

          4'b0111: branch <= ((inst_in[11] & (~extw[11] | extw[11])) & ~((~extw[11] | extw[11]) & ((inst_in[11] | ~inst_in[11]) & extw[11]))) | (~(inst_in[11] & (~extw[11] | extw[11])) & ((~extw[11] | extw[11]) & ((inst_in[11] | ~inst_in[11]) & extw[11])));

          4'b1000: branch <= (((sr_in[1] | inst_in[11]) & (~sr_in[1] | sr_in[1])) & ~inst_in[11]) | (((sr_in[1] | inst_in[11]) & (~sr_in[1] | sr_in[1])) & ~sr_in[1]);

          4'b1001: branch <= (inst_in[11] | (((~inst_in[11] & sr_in[3]) | ~sr_in[3]) & sr_in[3])) & ((~inst_in[11] & sr_in[3]) | ~sr_in[3]);

          4'b1010: branch <= (((~sr_in[5] | sr_in[5]) & (inst_in[11] | sr_in[5])) & ((sr_in[5] & (inst_in[11] & ~sr_in[5])) | (sr_in[5] & (~inst_in[11] & ((inst_in[11] | ~inst_in[11]) & (inst_in[11] | sr_in[5])))))) ^ (((~sr_in[5] | sr_in[5]) & (inst_in[11] | sr_in[5])) & (((~sr_in[5] & (inst_in[11] | ~inst_in[11])) | ~inst_in[11]) & ((~sr_in[5] | sr_in[5]) & inst_in[11])));

          4'b1011: branch <= ((((sr_in[11] | ~sr_in[11]) & inst_in[11]) | sr_in[11]) & ((sr_in[11] | ~sr_in[11]) & ((inst_in[11] | ~inst_in[11]) & sr_in[11]))) ^ ((((sr_in[11] | ~sr_in[11]) & inst_in[11]) | sr_in[11]) & ((sr_in[11] | ~sr_in[11]) & inst_in[11]));

          4'b1100: branch <= (((inst_in[11] | ~inst_in[11]) & sr_in[13]) & (inst_in[11] | ~inst_in[11])) ^ inst_in[11];

          4'b1101: branch <= ((((~inst_in[11] & sr_in[15]) | ~inst_in[11]) | (inst_in[11] & (~sr_in[15] & ((inst_in[11] & (~sr_in[15] | sr_in[15])) | sr_in[15])))) & (((inst_in[11] | ~inst_in[11]) & sr_in[15]) & (inst_in[11] | ~inst_in[11]))) ^ ((((~inst_in[11] & sr_in[15]) | ~inst_in[11]) | (inst_in[11] & (~sr_in[15] & ((inst_in[11] & (~sr_in[15] | sr_in[15])) | sr_in[15])))) & inst_in[11]);

          default: branch <= 1'b1;

        endcase

      end
endmodule

