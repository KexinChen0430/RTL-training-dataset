module sv_cast_string();
   string str;
   typedef logic [55:0] strbits;
   strbits chars;
   initial begin
      int i;
      str = "0123456";
      chars = strbits'(str);
      if(chars != 56'h30313233343536)
      begin
          $display("FAILED 1 chars = %x", chars);
          $finish();
      end
      str = "6543210";
      chars = strbits'(str);
      if(chars != "6543210")
      begin
          $display("FAILED 2 chars = %x", chars);
          $finish();
      end
      str = "wrong string";
      str = string'(chars);
      if(str != "6543210")
      begin
          $display("FAILED 3 str = %s", str);
          $finish();
      end
      $display("PASSED");
   end
endmodule