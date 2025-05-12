module Test (
   out,
   clk, in
   );
   input clk;
   input logic [4:0] in;
   output logic out;
   always @(posedge clk) begin
      out <= in inside {5'b1_1?1?};
   end
endmodule