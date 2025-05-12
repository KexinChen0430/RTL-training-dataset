module test;
   reg [1:0] foo = 2'b10;
   initial #1 begin
      while (foo) begin
	 $display("PASSED");
	 $finish;
      end
      $display("FAILED -- foo = %b", foo);
   end
endmodule