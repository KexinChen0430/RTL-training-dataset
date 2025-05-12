
module main;

  reg  [6*8:1] foo;

  
  initial  
  begin
    foo = PASSED;
    $display("%s",foo);
  end
endmodule

