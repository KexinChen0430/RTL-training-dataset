module comparator_model(clk, in, cmp);
   input clk;
   input real in;
   output logic cmp;
   always_ff @(posedge clk) begin
      cmp <= in > 0.0;
   end
endmodule