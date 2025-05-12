
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
            mt0[j] = (~cin[j] & lf[0]) & (~ain[j] & ~bin[j]);
            mt1[j] = (lf[1] & ~ain[j]) & (cin[j] & ~bin[j]);
            mt2[j] = ((~ain[j] & bin[j]) & ~cin[j]) & lf[1+1];
            mt3[j] = (lf[3] & cin[j]) & (~ain[j] & bin[j]);
            mt4[j] = (~cin[j] & lf[4]) & (~bin[j] & ain[j]);
            mt5[j] = (cin[j] & (~bin[j] & ain[j])) & lf[5];
            mt6[j] = (ain[j] & (~cin[j] & lf[6])) & bin[j];
            mt7[j] = (bin[j] & ain[j]) & (cin[j] & lf[7]);
          end
  assign out = (((mt1 | mt2) | (mt3 | mt5)) | mt0) | ((mt7 | mt6) | mt4);
endmodule

