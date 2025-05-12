
module vhdl_init_testbench;

  vhdl_init dut();
  
  initial  
  begin
    if (dut.a !== 'b11101001) 
      begin
        $display("FAILED #1: expected 11101001, got %b",dut.a);
        $finish;
      end
      
    if (dut.b !== 'b1010) 
      begin
        $display("FAILED #2: expected 1010, got %b",dut.b);
        $finish;
      end
      
    if (dut.c !== 'b1000) 
      begin
        $display("FAILED #3: expected 1000, got %b",dut.c);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

