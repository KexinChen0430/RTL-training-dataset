module main;
   reg foo, bar;
   reg foo_ok = 0, bar_ok = 0;
   initial foo = 1;
   always @(foo) begin
      if (foo !== 1'b1) begin
	 $display("FAILED --(foo = %b)", foo);
	 $finish;
      end
      foo_ok = 1;
   end
   always @(bar) begin
      if (bar !== 1'b1) begin
	 $display("FAILED --(bar = %b)", bar);
	 $finish;
      end
      bar_ok = 1;
   end
   initial bar = 1;
   initial begin
      #1 if (foo_ok !== 1) begin
	 $display("FAILED -- foo lost the race");
	 $finish;
      end
      if (bar_ok !== 1) begin
	 $display("FAILED -- bar lost the race");
	 $finish;
      end
      $display("PASSED");
   end 
endmodule