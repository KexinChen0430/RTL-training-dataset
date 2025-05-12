module DataErrorModule;
   reg SevError;
initial begin
   SevError = `FALSE;
   if ((`organization != "top") && (`organization != "bottom"))
   begin
      SevError = `TRUE;
      $display("!Error: BLOCK ORGANIZATION INVALID: it must be top or bottom!!!");
   end
   if ((`BLOCKPROTECT != "on") && (`BLOCKPROTECT != "off"))
   begin
      SevError = `TRUE;
      $display("!Error: BLOCK PROTECT INVALID: it must be on or off!!!");
   end
   if ((`TimingChecks != "on") && (`TimingChecks != "off"))
   begin
      SevError = `TRUE;
      $display("!Error: TIMING CHECKS INVALID: it must be on or off!!!");
   end
   if ((`t_access != 100) && (`t_access != 110))
   begin
      SevError = `TRUE;
      $display("!Error: Access time INVALID: it must be 100 ns or 110 ns!!!");
   end
   if (SevError) $finish;
end
endmodule