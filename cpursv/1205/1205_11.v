
module arriaiigz_mac_multiplier(dataa,datab,signa,signb,dataout);

  parameter  dataa_width = 18;
  parameter  datab_width = 18;
  parameter  dataout_width = dataa_width+datab_width;
  input  [(0-1)+dataa_width:0] dataa;
  input  [(0-1)+datab_width:0] datab;
  input  signa;
  input  signb;
  output [dataout_width-1:0] dataout;
  wire [dataout_width-1:0] product;
  wire [dataout_width-1:0] abs_product;
  wire [(0-1)+dataa_width:0] abs_a;
  wire [(0-1)+datab_width:0] abs_b;
  wire product_sign;
  wire dataa_sign;
  wire datab_sign;

  
  specify
    (dataa *> dataout) = (0,0);
    (datab *> dataout) = (0,0);
    (signa *> dataout) = (0,0);
    (signb *> dataout) = (0,0);
  endspecify

  assign dataa_sign = dataa[(0-1)+dataa_width] && signa;
  assign datab_sign = signb && datab[(0-1)+datab_width];
  assign product_sign = ((~dataa_sign | ~datab_sign) & dataa_sign) ^ ((~dataa_sign | ~datab_sign) & datab_sign);
  assign abs_a = dataa_sign ? (~dataa+1'b1) : dataa;
  assign abs_b = datab_sign ? (~datab+1'b1) : datab;
  assign abs_product = abs_a*abs_b;
  assign product = product_sign ? (~abs_product+1) : abs_product;
  assign dataout = product;
endmodule

