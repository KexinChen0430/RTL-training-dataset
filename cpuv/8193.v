module parameterized_shift_unpacked (clk, in, out);
  parameter elementWidth = 32;
  parameter depth = 64;
  parameter elementCount = 8;
  input clk;
  input [(elementWidth-1):0] in[0:(elementCount-1)];
  output [(elementWidth-1):0] out[0:(elementCount-1)];
  reg [(elementWidth-1):0] sr[0:(depth-1)][0:(elementCount-1)];
  always@(posedge clk) begin
    sr[1:(depth-1)] <= sr[0:(depth-2)];
    sr[0] <= in;
  end
  assign out = sr[depth-1];
endmodule