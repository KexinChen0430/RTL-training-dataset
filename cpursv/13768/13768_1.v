
module bus_w(input  mwc,mwb,mwa,
             input  bwa,bwb,
             input  [0:15] ir,
             input  [0:15] kl,
             input  [0:15] rdt,
             input  [0:15] ki,
             input  [0:15] at,
             input  [0:15] ac,
             input  [0:15] a,
             output [0:15] w);

  
  always @(*)
      begin
        case ({bwb,mwc,mwb,mwa})

          4'b0000: w[0:7] = a[0:7];

          4'b0001: w[0:7] = ac[0:7];

          4'b0010: w[0:7] = at[0:7];

          4'b0011: w[0:7] = ki[0:7];

          4'b0100: w[0:7] = 8'd0;

          4'b0101: w[0:7] = rdt[0:7];

          4'b0110: w[0:7] = kl[0:7];

          4'b0111: w[0:7] = ir[0:7];

          default: w[0:7] = 8'd0;

        endcase

        case ({bwa,mwc,mwb,mwa})

          4'b0000: w[8:15] = a[8:15];

          4'b0001: w[8:15] = ac[8:15];

          4'b0010: w[8:15] = at[8:15];

          4'b0011: w[8:15] = ki[8:15];

          4'b0100: w[8:15] = ac[0:7];

          4'b0101: w[8:15] = rdt[8:15];

          4'b0110: w[8:15] = kl[8:15];

          4'b0111: w[8:15] = ir[8:15];

          default: w[8:15] = 8'd0;

        endcase

      end
endmodule

