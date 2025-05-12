
module vhdl_boolean_test;

  vhdl_boolean dut();
  
  initial  
  begin
    if (dut.true_val != \true) 
      begin
        $display("FAILED true 1");
        $finish;
      end
      
    if (!dut.true_val) 
      begin
        $display("FAILED true 2");
        $finish;
      end
      
    if (dut.false_val != \false) 
      begin
        $display("FAILED false 1");
        $finish;
      end
      
    if (dut.false_val) 
      begin
        $display("FAILED false 2");
        $finish;
      end
      
    if (!dut.and1) 
      begin
        $display("FAILED and1");
        $finish;
      end
      
    if (dut.and2) 
      begin
        $display("FAILED and2");
        $finish;
      end
      
    if (dut.and3) 
      begin
        $display("FAILED and3");
        $finish;
      end
      
    if (!dut.or1) 
      begin
        $display("FAILED or1");
        $finish;
      end
      
    if (!dut.or2) 
      begin
        $display("FAILED or2");
        $finish;
      end
      
    if (dut.or3) 
      begin
        $display("FAILED or3");
        $finish;
      end
      
    if (!dut.not1) 
      begin
        $display("FAILED not1");
        $finish;
      end
      
    if (dut.not2) 
      begin
        $display("FAILED not2");
        $finish;
      end
      
    $display("PASSED");
  end
endmodule

