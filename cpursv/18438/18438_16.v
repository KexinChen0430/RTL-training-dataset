
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w128  ,
      w129  ,
      w16384,
      w16513,
      w2064 ,
      w18577,
      w516  ,
      w19093;

  assign w1 = i_data0;
  assign w128 = w1*(2**7);
  assign w129 = w1+w128;
  assign w16384 = w1<<<14;
  assign w16513 = w16384+w129;
  assign w18577 = w2064+w16513;
  assign w19093 = w516+w18577;
  assign w2064 = w129<<<4;
  assign w516 = (2**2)*w129;
  assign o_data0 = w19093;
endmodule

