module dmod (input clk, input [31:0] n);
`ifdef INLINE_D 
`else  
`endif
   reg [31:0] dlocal;
   always @ (posedge clk) dlocal <= n;
   int cyc;
   always @(posedge clk) begin
      cyc <= cyc + 1;
   end
   always @(posedge clk) begin
      if (cyc > 10) begin
         `ifdef TEST_VERBOSE
         $display("%m: csub.clocal=%0d  dlocal=%0d", csub.clocal, dlocal);
         `endif
         if (csub.clocal !== n) $stop;
         if (dlocal !== n) $stop;
      end
      if (cyc == 99) begin
         $write("*-* All Finished *-*\n");
         $finish;
      end
   end
endmodule