module t ();
   initial begin
      Cls c;
      c = new;
      c.b1member = 10;
      c.b2member = 30;
      c.imembera = 100;
      c.imemberb = 110;
      c.imemberc = 120;
      $display("Display: set = \"%p\"", c);  
      if (c.b1member != 10) $stop;
      if (c.b2member != 30) $stop;
      if (c.imembera != 100) $stop;
      if (c.imemberb != 110) $stop;
      if (c.imemberc != 120) $stop;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule