
module main;

  reg  [3:0] value1;

  
  initial  
  begin
    #3 
      if (value1 != 4'h1) 
        $display("FAILED - 3.1.3B always assign reg_lvalue = boolean_expr");
      else 
        $display(PASSED);

    $finish;
  end
  
  always   #2 assign value1 = 1'b1;
endmodule

