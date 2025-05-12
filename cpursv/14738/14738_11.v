
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
            mt0[j] = (~ain[j] & (~cin[j] & lf[0])) & ~bin[j];
            mt1[j] = (lf[1] & ~ain[j]) & (cin[j] & ~bin[j]);
            mt2[j] = (~cin[j] & (~ain[j] & bin[j])) & lf[1+1];
            mt3[j] = cin[j] & ((lf[3] & bin[j]) & ~ain[j]);
            mt4[j] = (~cin[j] & ~bin[j]) & (lf[4] & ain[j]);
            mt5[j] = (cin[j] & (lf[5] & ain[j])) & ~bin[j];
            mt6[j] = (bin[j] & ~cin[j]) & (lf[6] & ain[j]);
            mt7[j] = ((ain[j] & lf[7]) & bin[j]) & cin[j];
          end
  assign out = ((mt4 | mt3) | ((mt7 | mt5) | mt6)) | ((mt0 | mt2) | mt1);
endmodule

