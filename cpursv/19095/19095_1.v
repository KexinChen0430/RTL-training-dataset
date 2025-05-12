
module vhdl_array_of_array_test;

  vhdl_array_of_array dut();
  
  initial  
  begin
    if (dut.sig[0] !== 8'haa) 
      begin
        $display(FAILED);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

