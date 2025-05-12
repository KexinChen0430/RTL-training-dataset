
module test;

  reg  i;

  
  initial  
  begin
    i = 0;
    $display("~i = %d",~i);
    $display(PASSED);
  end
endmodule

