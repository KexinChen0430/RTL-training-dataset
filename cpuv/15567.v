module t1(intf mod_intf);
   initial begin
      $display("%m %d", mod_intf.val);
   end 
endmodule 