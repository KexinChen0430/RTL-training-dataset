module m3
  #(
    parameter  UNCH = 99,
    parameter  P1 = 10,
    parameter  P2 = 20,
               P3 = 30
    )
    (
     clk
     );
   input       clk;
   localparam  LOC = 13;
   parameter   FROMDEFP = 11;
   initial begin
      $display("%x %x %x",P1,P2,P3);
   end
   always @ (posedge clk) begin
      if (UNCH !== 99) $stop;
      if (P1 !== 10) $stop;
      if (P2 !== 2) $stop;
      if (P3 !== 3) $stop;
`ifdef verilator
      if (FROMDEFP !== 19) $stop;
`endif
   end
endmodule