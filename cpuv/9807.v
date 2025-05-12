module Checker (clk, value);
  input clk, value;
  always @(posedge clk) begin
      $write ("[%0t] value=%h\n", $time, value);
   end
endmodule