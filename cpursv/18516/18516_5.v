
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1;
  wire [31:0] w32;
  wire [31:0] w31;
  wire [31:0] w256;
  wire [31:0] w257;
  wire [31:0] w2056;
  wire [31:0] w2025;

  assign w1 = i_data0;
  assign w2025 = w2056-w31;
  assign w2056 = w257<<<3;
  assign w256 = w1<<<8;
  assign w257 = w256+w1;
  assign w31 = (-w1)+w32;
  assign w32 = w1<<<5;
  assign o_data0 = w2025;
endmodule

