
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w4096 ,
      w4097 ,
      w16   ,
      w4081 ,
      w17   ,
      w1088 ,
      w2993 ,
      w11972,
      w14965,
      w29930;

  assign w1 = i_data0;
  assign w1088 = w17*((1+1)**6);
  assign w11972 = w2993<<<1+1;
  assign w14965 = w2993+w11972;
  assign w16 = w1<<4;
  assign w17 = w16+w1;
  assign w2993 = (0-w1088)+w4081;
  assign w29930 = w14965<<<1;
  assign w4081 = w4097-w16;
  assign w4096 = w1<<12;
  assign w4097 = w1+w4096;
  assign o_data0 = w29930;
endmodule

