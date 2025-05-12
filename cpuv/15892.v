module real_to_vec (input wire [3:0] in);
  always @(in)
    if (in !== $stime) begin
      $display("Failed real_to_vec %m at %1d, got %0d, expected %0d",
               $stime, in, $stime);
      top.pass = 1'b0;
    end
endmodule