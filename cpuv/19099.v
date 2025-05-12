module vhdl_unbounded_func_test();
  vhdl_unbounded_func dut();
  initial begin
    #1;   
    if(dut.test_out1 != 'b1010100110) begin
      $display("FAILED 1"); 
      $finish;              
    end
    if(dut.test_out2 != 'b010110) begin
      $display("FAILED 2"); 
      $finish;              
    end
    if(dut.neg_test_out1 != ~dut.test_out1) begin
      $display("FAILED 3"); 
      $finish;              
    end
    if(dut.neg_test_out2 != ~dut.test_out2) begin
      $display("FAILED 4"); 
      $finish;              
    end
    $display("PASSED");
  end
endmodule