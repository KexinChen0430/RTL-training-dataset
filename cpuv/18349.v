module vhdl_real_testbench;
  vhdl_real dut();
  initial begin
    if (dut.c != 1111.222) begin
      $display("FAILED"); 
      $finish;            
    end
    if (dut.e != 1135.022) begin
      $display("FAILED"); 
      $finish;            
    end
    if (dut.a != 1.2) begin
      $display("FAILED"); 
      $finish;            
    end
    if (dut.b != 32.12323) begin
      $display("FAILED"); 
      $finish;            
    end
    if (dut.exp != 2.334e+2) begin
      $display("FAILED"); 
      $finish;            
    end
    #10;    
    if (dut.no_init != 33.32323) begin
      $display("FAILED"); 
      $finish;            
    end
    $display("PASSED"); 
  end
endmodule