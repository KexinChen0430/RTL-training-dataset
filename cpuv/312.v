module clkif_334;
   always @(posedge top.clk iff !top.clken_l) begin
   end
endmodule