
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
  assign w2025 = (0-w31)+w2056;
  assign w2056 = ((1+1)**3)*w257;
  assign w256 = ((1+1)**8)*w1;
  assign w257 = w1+w256;
  assign w31 = w32-w1;
  assign w32 = w1*((1+1)**5);
  assign o_data0 = w2025;
endmodule

