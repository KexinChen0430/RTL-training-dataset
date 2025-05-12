
module main;

  reg  [3:0] value1;

  
  initial    if (value1 != 4'h5) 
    $display("FAILED - 3.1.3A always assign reg_lvalue = constant\n");
  else 
    begin
      $display(PASSED\n);
      $finish;
    end
  
  always   assign value1 = 4'h5;
endmodule

