module sub_check
  (
   ifc intf_for_check
   );
`ifdef NO_INLINE_A
`endif
   always @(posedge intf_for_check.clk) begin
      if (intf_for_check.the_struct.val100 != intf_for_check.value + 100) $stop;
      if (intf_for_check.the_struct.val200 != intf_for_check.value + 200) $stop;
   end 
endmodule 