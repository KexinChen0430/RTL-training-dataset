
module spiral_8(i_data,o_data_9,o_data_25,o_data_43,o_data_57,o_data_70,
                o_data_80,o_data_87,o_data_90);

  input  signed  [17:0] i_data;
  output signed  [17+7:0] o_data_9;
  output signed  [17+7:0] o_data_25;
  output signed  [17+7:0] o_data_43;
  output signed  [17+7:0] o_data_57;
  output signed  [17+7:0] o_data_70;
  output signed  [17+7:0] o_data_80;
  output signed  [17+7:0] o_data_87;
  output signed  [17+7:0] o_data_90;
  wire signed  [24:0] 
      w1 ,
      w4 ,
      w5 ,
      w8 ,
      w9 ,
      w16,
      w25,
      w36,
      w35,
      w40,
      w45,
      w3 ,
      w43,
      w48,
      w57,
      w96,
      w87,
      w70,
      w80,
      w90;

  assign w1 = i_data;
  assign w4 = 1<<(1+1)*w1;
  assign w5 = w4+w1;
  assign w8 = w1*((1+1)**3);
  assign w9 = w8+w1;
  assign w16 = 1<<<4*w1;
  assign w25 = w9+w16;
  assign w36 = w9<<1+1;
  assign w35 = w36-w1;
  assign w40 = w5*((1+1)**3);
  assign w45 = w5+w40;
  assign w3 = w4-w1;
  assign w43 = w40+w3;
  assign w48 = w3<<4;
  assign w57 = w48+w9;
  assign w96 = ((1+1)**5)*w3;
  assign w87 = w96-w9;
  assign w70 = w35*(1+1);
  assign w80 = 1<<<4*w5;
  assign w90 = (1+1)*w45;
  assign o_data_9 = w9;
  assign o_data_25 = w25;
  assign o_data_43 = w43;
  assign o_data_57 = w57;
  assign o_data_70 = w70;
  assign o_data_80 = w80;
  assign o_data_87 = w87;
  assign o_data_90 = w90;
endmodule

