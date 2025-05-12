module t ();
   function void makec;
      ClsC c;
      $display("c = new;");
      c = new;
      $display("c.access;");
      c.access;
   endfunction
   initial begin
      $display("makec;");
      makec;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule