module main;
   reg a, b, c;
   wire d = a & ~b;  
   reg [2:0] tmp;
   reg       ref;
   initial begin
      for (tmp = 0; tmp < 4; tmp = tmp + 1) begin
         a = tmp[0];
         b = tmp[1];
         c = a & ~b;
         #1 if (c != d) begin
            $display("FAILED -- a=%b, b=%b, c=%b, d=%b",
                     a, b, c, d);
            $finish;
         end
      end 
      $display("PASSED");
   end
endmodule