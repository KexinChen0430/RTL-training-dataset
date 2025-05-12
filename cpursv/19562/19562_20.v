
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w1024,w1025,w32,w993,w3972,w31776,w30751,w26779;

  assign w1 = i_data0;
  assign w1024 = w1<<10;
  assign w1025 = w1+w1024;
  assign w26779 = (-w3972)+w30751;
  assign w30751 = (0-w1025)+w31776;
  assign w31776 = w993*1<<<5;
  assign w32 = w1<<<5;
  assign w3972 = ((1<<<1+1)+1)*w993;
  assign w993 = (-w32)+w1025;
  assign o_data0 = w26779;
endmodule

