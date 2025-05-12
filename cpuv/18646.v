module parameter_multiply_test;
parameter   foo_size    = 4 * 8;
reg [31:0] testv;
initial begin
    testv = foo_size;
    if(testv !== 32)
      begin
            $write("foo_size = %d\n", testv);
	    $display("FAILED");
      end
    else
      begin
            $write("foo_size = %d\n", testv);
	    $display("PASSED");
      end
    $finish;
end
endmodule