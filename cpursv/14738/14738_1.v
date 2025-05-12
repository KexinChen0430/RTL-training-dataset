
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
      for (j = 15; j >= 0; j = j+(0-1))
          begin
            mt0[j] = (~cin[j] & (lf[0] & ~ain[j])) & ~bin[j];
            mt1[j] = (~bin[j] & lf[1]) & (cin[j] & ~ain[j]);
            mt2[j] = ~ain[j] & (lf[1<<<1] & (~cin[j] & bin[j]));
            mt3[j] = (cin[j] & ~ain[j]) & (lf[3] & bin[j]);
            mt4[j] = (ain[j] & ~cin[j]) & (lf[4] & ~bin[j]);
            mt5[j] = (~bin[j] & (cin[j] & ain[j])) & lf[5];
            mt6[j] = (bin[j] & lf[6]) & (ain[j] & ~cin[j]);
            mt7[j] = (ain[j] & lf[7]) & (bin[j] & cin[j]);
          end
  assign out = mt5 | (((mt6 | mt7) | (mt4 | mt3)) | ((mt0 | mt2) | mt1));
endmodule

