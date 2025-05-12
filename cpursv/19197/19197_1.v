
module subprogram_test;

  subprogram dut();
  
  initial  
  begin
    #1 ;
    if (dut.negated !== 'b00111000) 
      begin
        $display("FAILED 1");
        $finish;
      end
      
    if (dut.reversed != 'b11100001) 
      begin
        $display("FAILED 2");
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

