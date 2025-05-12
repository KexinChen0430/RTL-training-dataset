
module xlslice(x,y);

  parameter  new_msb = 9;
  parameter  new_lsb = 1;
  parameter  x_width = 16;
  parameter  y_width = 8;
  input  [(-1)+x_width:0] x;
  output [(-1)+y_width:0] y;

  assign y = x[new_msb:new_lsb];
endmodule

