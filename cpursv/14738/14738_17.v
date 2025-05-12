
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
      for (j = 15; j >= 0; j = (0-1)+j)
          begin
            mt0[j] = (~ain[j] & ~bin[j]) & (lf[0] & ~cin[j]);
            mt1[j] = (cin[j] & lf[1]) & (~ain[j] & ~bin[j]);
            mt2[j] = ~cin[j] & ((~ain[j] & bin[j]) & lf[1+1]);
            mt3[j] = (lf[3] & ~ain[j]) & (cin[j] & bin[j]);
            mt4[j] = (~bin[j] & (lf[4] & ain[j])) & ~cin[j];
            mt5[j] = (lf[5] & ~bin[j]) & (cin[j] & ain[j]);
            mt6[j] = (ain[j] & bin[j]) & (~cin[j] & lf[6]);
            mt7[j] = (ain[j] & (lf[7] & bin[j])) & cin[j];
          end
  assign out = (mt3 | mt4) | (((mt6 | mt5) | mt7) | ((mt2 | mt1) | mt0));
endmodule

