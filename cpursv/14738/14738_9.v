
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
      for (j = 15; j >= 0; j = j-1)
          begin
            mt0[j] = ~bin[j] & ((~ain[j] & ~cin[j]) & lf[0]);
            mt1[j] = (~ain[j] & cin[j]) & (~bin[j] & lf[1]);
            mt2[j] = (~ain[j] & lf[1+1]) & (bin[j] & ~cin[j]);
            mt3[j] = (~ain[j] & (bin[j] & lf[3])) & cin[j];
            mt4[j] = (ain[j] & lf[4]) & (~bin[j] & ~cin[j]);
            mt5[j] = (ain[j] & cin[j]) & (~bin[j] & lf[5]);
            mt6[j] = (ain[j] & bin[j]) & (~cin[j] & lf[6]);
            mt7[j] = (ain[j] & lf[7]) & (cin[j] & bin[j]);
          end
  assign out = mt2 | (((mt0 | mt1) | (mt3 | mt4)) | (mt7 | (mt5 | mt6)));
endmodule

