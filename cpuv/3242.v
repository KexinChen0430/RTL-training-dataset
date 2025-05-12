module prescaler #(
  parameter [31:0] SCALE = 28
)(
  input  wire       clock;
  input  wire       reset;
  input  wire [1:0] div;
  output reg        scaled;
);
always @ (*)
scaled = 1'b1;
endmodule