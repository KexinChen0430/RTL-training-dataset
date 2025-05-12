module testmod
  (
   input clk, 
   test_if.mp intf, 
   test_if intf_no_mp 
   );
   localparam THE_FOO = intf.FOO;
   localparam THE_OTHER_FOO = intf_no_mp.FOO;
   always @(posedge clk) begin
      if (THE_FOO != 5) begin
         $display("%%Error: THE_FOO = %0d", THE_FOO);
	 $stop;
      end
      if (THE_OTHER_FOO != 5) begin
         $display("%%Error: THE_OTHER_FOO = %0d", THE_OTHER_FOO);
         $stop;
      end
      if (intf.FOO != 5) begin
         $display("%%Error: intf.FOO = %0d", intf.FOO);
	 $stop;
      end
      if (intf_no_mp.FOO != 5) begin
         $display("%%Error: intf_no_mp.FOO = %0d", intf_no_mp.FOO);
         $stop;
      end
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule