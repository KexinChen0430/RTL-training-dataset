module sub_struct 
  (
   ifc intf_for_struct 
   );
   always @(*) begin
      intf_for_struct.the_struct.val100 = intf_for_struct.value + 100;
      intf_for_struct.the_struct.val200 = intf_for_struct.value + 200;
   end 
endmodule 