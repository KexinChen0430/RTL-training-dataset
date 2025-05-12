module test;
parameter A0 = 2'b10 | 2'b01 ;
initial
  begin
   if(A0 !== 2'b11)
      $display("FAILED - A0 expression OR doesn't work.");
   else
      $display("PASSED");
  end
endmodule