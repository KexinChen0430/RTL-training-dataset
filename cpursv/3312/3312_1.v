
module MUXF7(output O,
             input  I0,I1,S);

  assign O = S ? I1 : I0;
  
  specify
    (I0 => O) = 217;
    (I1 => O) = 223;
    (S => O) = 296;
  endspecify

endmodule

