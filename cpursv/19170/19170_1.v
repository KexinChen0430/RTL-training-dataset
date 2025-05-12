
module main;

  parameter  FOO = 0;

  
  initial  
  begin
    if ((FOO < -255) || (FOO > 255)) 
      begin
        $display("FAILED -- foo=%d does not fall in the range?",FOO);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

