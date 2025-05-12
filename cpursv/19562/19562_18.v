
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w1024,w1025,w32,w993,w3972,w31776,w30751,w26779;

  assign w1 = i_data0;
  assign w1024 = ((1+1)**10)*w1;
  assign w1025 = w1024+w1;
  assign w26779 = (0-w3972)+w30751;
  assign w30751 = w31776-w1025;
  assign w31776 = w993<<<5;
  assign w32 = w1<<5;
  assign w3972 = (1+(1+(1+1)))*w993;
  assign w993 = (0-w32)+w1025;
  assign o_data0 = w26779;
endmodule

