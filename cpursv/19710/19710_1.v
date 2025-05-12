
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    #15 ;
    if (value1 != 4'h5) 
      $display("FAILED - 3.1.3H always release rev_lvalue;\n");
    else 
      begin
        $display(PASSED\n);
        $finish;
      end
  end
  
  always   release value1;
endmodule

