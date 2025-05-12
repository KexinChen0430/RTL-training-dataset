
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    #20 ;
    $display(PASSED\n);
    $finish;
  end
  
  always   #10 ;
endmodule

