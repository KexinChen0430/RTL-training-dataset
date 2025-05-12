
module add(out,in);

  parameter  PASSDOWN = 9999;
  input  [31:0] in;
  output [31:0] out;
  wire  out = in+PASSDOWN;


endmodule

