module t (
   clk
   );
   input clk;
   localparam [ 0:0] one1_lp  = 1; 
   localparam [ 1:0] one2_lp  = 1; 
   localparam [69:0] one70_lp = 1; 
   bit all_ok = 1;
   initial begin
      `ifdef TEST_VERBOSE
         $display("one1_lp : %x %d", one1_lp, one1_lp==1);
      `endif
      all_ok &= one1_lp  == 1;
      if (!all_ok) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule