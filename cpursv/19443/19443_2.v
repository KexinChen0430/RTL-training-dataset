
module test;

  reg  [31:0] c;

  
  initial  
  begin
    c = 13;
    if (c & 4) 
      begin
        $display(PASSED);
        $finish;
      end
      
    $display(FAILED);
  end
endmodule

