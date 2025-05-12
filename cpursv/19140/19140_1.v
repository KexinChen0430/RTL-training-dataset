
module main;

  reg  [3:0] a;
  wire b;

  assign b = !a;
  
  initial  
  begin
    a = 4'd1;
    #1 ;
    if (b !== 0) 
      begin
        $display(FAILED);
        $finish;
      end
      
    a = 4'd0;
    #1 ;
    if (b !== 1) 
      begin
        $display(FAILED);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

