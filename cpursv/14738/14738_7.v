
module bltminterm(input  [7:0] lf,
                  input  [15:0] ain,
                  input  [15:0] bin,
                  input  [15:0] cin,
                  output [15:0] out);

  reg  [15:0] mt0;
  reg  [15:0] mt1;
  reg  [15:0] mt2;
  reg  [15:0] mt3;
  reg  [15:0] mt4;
  reg  [15:0] mt5;
  reg  [15:0] mt6;
  reg  [15:0] mt7;
  integer j;

  
  always @(ain or bin or cin or lf)
      for (j = 15; j >= 0; j = (-1)+j)
          begin
            mt0[j] = ~ain[j] & ((~cin[j] & ~bin[j]) & lf[0]);
            mt1[j] = (~ain[j] & (lf[1] & cin[j])) & ~bin[j];
            mt2[j] = (~ain[j] & bin[j]) & (lf[1<<1] & ~cin[j]);
            mt3[j] = (bin[j] & cin[j]) & (~ain[j] & lf[3]);
            mt4[j] = (lf[4] & (~cin[j] & ~bin[j])) & ain[j];
            mt5[j] = (ain[j] & cin[j]) & (lf[5] & ~bin[j]);
            mt6[j] = lf[6] & (bin[j] & (~cin[j] & ain[j]));
            mt7[j] = (ain[j] & cin[j]) & (lf[7] & bin[j]);
          end
  assign out = mt3 | ((mt6 | (mt7 | mt5)) | ((mt1 | mt0) | (mt4 | mt2)));
endmodule

