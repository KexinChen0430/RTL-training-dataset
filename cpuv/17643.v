module sinkMod
  (
   validData.sink ctrl,
   output logic valid_data
   );
   always_ff @(posedge ctrl.clk) begin
      if (ctrl.valid) valid_data <= ctrl.data;
   end
endmodule