module vhdl_unbounded_array_test;
  vhdl_unbounded_array dut();
  initial begin
    #1;   
    if(dut.sig_logic != 'b01010101) begin
      $display("FAILED 1"); 
      $finish;              
    end
    if(dut.sig_integer[2] != 1) begin
      $display("FAILED 2"); 
      $finish;              
    end
    if(dut.sig_real[1] != 2.5) begin
      $display("FAILED 3"); 
      $finish;              
    end
    $display("PASSED");
  end
endmodule