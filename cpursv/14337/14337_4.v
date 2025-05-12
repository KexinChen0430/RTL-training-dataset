
module MUX_ARRAY(O,B_R,A,B,sel,clk);

  parameter  m = 163;
  input  wire [0:(0-1)+m] A,B;
  output wire [0:(0-1)+m] O,B_R;
  input  wire sel,clk;
  wire [0:(0-1)+m] temp;

  MUX mu[0:(0-1)+m](O,A,B,sel);
  assign B_R = O;
endmodule

