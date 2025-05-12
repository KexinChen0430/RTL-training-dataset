module tag ();
   bit [100*8-1:0] scope;
   initial begin
      $sformat(scope,"%m");
      $display("created tag with scope = %0s",scope);
   end
endmodule