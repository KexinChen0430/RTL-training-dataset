
module stratixiii_mac_multiplier(dataa,datab,signa,signb,dataout);

  parameter  dataa_width = 18;
  parameter  datab_width = 18;
  parameter  dataout_width = dataa_width+datab_width;
  input  [dataa_width+(-1):0] dataa;
  input  [(-1)+datab_width:0] datab;
  input  signa;
  input  signb;
  output [(-1)+dataout_width:0] dataout;
  wire [(-1)+dataout_width:0] product;
  wire [(-1)+dataout_width:0] abs_product;
  wire [dataa_width+(-1):0] abs_a;
  wire [(-1)+datab_width:0] abs_b;
  wire product_sign;
  wire dataa_sign;
  wire datab_sign;

  
  specify
    (dataa *> dataout) = (0,0);
    (datab *> dataout) = (0,0);
    (signa *> dataout) = (0,0);
    (signb *> dataout) = (0,0);
  endspecify

  assign dataa_sign = signa && dataa[dataa_width+(-1)];
  assign datab_sign = datab[(-1)+datab_width] && signb;
  assign product_sign = (((~dataa_sign | dataa_sign) | (~dataa_sign & (datab_sign | (dataa_sign & (datab_sign | ~datab_sign))))) & datab_sign) ^ (((~dataa_sign | dataa_sign) | (~dataa_sign & (datab_sign | (dataa_sign & (datab_sign | ~datab_sign))))) & (dataa_sign & (datab_sign | ~datab_sign)));
  assign abs_a = dataa_sign ? (1'b1+~dataa) : dataa;
  assign abs_b = datab_sign ? (1'b1+~datab) : datab;
  assign abs_product = abs_a*abs_b;
  assign product = product_sign ? (~abs_product+1) : abs_product;
  assign dataout = product;
endmodule

