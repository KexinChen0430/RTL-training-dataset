
module main;

  reg  [3:0] value1;

  
  always 
      begin
        #0 ;
        #0 ;
        #0 ;
      end
  
  always   value1 = 4'h5;
  
  initial    if (value1 != 4'h5) 
    $display("FAILED - 3.1.1A always reg_lvalue = constant\n");
  else 
    begin
      $display(PASSED\n);
      $finish;
    end
endmodule

