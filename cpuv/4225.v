module to apply values to the inputs and
   input clk;
   input [31:0] in;
   output reg [31:0] out;
   always @(posedge clk) begin
      out <= in;
   end
endmodule