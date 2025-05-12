module sourceMod
(
 validData.source ctrl
);
always_ff @(posedge ctrl.clk) begin
   ctrl.data <= ~ctrl.data;
   ctrl.valid <= ~ctrl.valid;
end
endmodule