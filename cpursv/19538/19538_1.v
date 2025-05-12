
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    #1 ;
    if (value1 != 4'bxxxx) 
      $display("FAILED - 3.1.4B - initial value not xxxx;\n");
      
    #15 ;
    if (value1 != 4'h5) 
      $display("FAILED - 3.1.4B - always # delay_value reg_lvalue = constant\n");
    else 
      begin
        $display(PASSED\n);
        $finish;
      end
  end
  
  always   #10 value1 = 4'h5;
endmodule

