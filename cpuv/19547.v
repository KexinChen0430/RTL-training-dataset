module test();
   reg  [7:0]  test;
   wire [7:0]  neg_test = -test;
   initial begin
      for (test = 0 ;  test < 255 ;  test = test + 1) begin
	 #1 if (neg_test !== (-test)) begin
	    $display("FAILED -- %b !== -%b", neg_test, test);
	    $finish;
	 end
      end
      $display("PASSED");
   end
endmodule