module checkstr;
   parameter int PINID = " ";
   parameter int EXP   = " ";
   initial begin
      $display("PID %s  EXP %s", PINID, EXP);
      if (EXP != "ERR" && EXP != "PA0") $stop;
      if (PINID != EXP) $stop;
   end
endmodule