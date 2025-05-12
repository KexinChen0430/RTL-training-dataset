module test; 
parameter A0 = 4'b0011 % 4'b0010; 
initial
  begin
   if(A0 !== 4'b0001)
      $display("FAILED - Mod in a param declaration."); 
   else
      $display("PASSED"); 
  end
endmodule 