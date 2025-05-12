
module system_microblaze_0_xlconcat_0(In0,In1,In2,In3,In4,In5,In6,dout);

  input  In0;
  input  In1;
  input  In2;
  input  In3;
  input  In4;
  input  In5;
  input  In6;
  output [6:0] dout;
  wire In0;
  wire In1;
  wire In2;
  wire In3;
  wire In4;
  wire In5;
  wire In6;

  assign dout[6] = In6;
  assign dout[5] = In5;
  assign dout[4] = In4;
  assign dout[3] = In3;
  assign dout[2] = In2;
  assign dout[1] = In1;
  assign dout[0] = In0;
endmodule

