
module vhdl_rtoi_testbench;

  vhdl_rtoi dut();
  
  initial  
  begin
    #1 ;
    if (dut.a !== 2) 
      begin
        $display("FAILED 1");
        $finish;
      end
      
    if (dut.b !== 4) 
      begin
        $display("FAILED 2");
        $finish;
      end
      
    if (dut.c !== 5) 
      begin
        $display("FAILED 3");
        $finish;
      end
      
    if (dut.d !== 17) 
      begin
        $display("FAILED 4");
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

