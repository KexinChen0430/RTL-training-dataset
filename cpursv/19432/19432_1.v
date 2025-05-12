
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    #15 ;
    if (value1 !== 4'h5) 
      $display("FAILED - 3.1.3D always force reg_lvalue = constant;");
    else 
      $display(PASSED);
    $finish;
  end
  
  always   #10 force value1 = 4'h5;
endmodule

