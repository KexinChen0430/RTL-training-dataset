
module test;

  reg  [31:0] c;

  
  initial  
  begin
    c = 13;
    if (4 & c) 
      begin
        $display(PASSED);
        $finish;
      end
      
    $display(FAILED);
  end
endmodule

