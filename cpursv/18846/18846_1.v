
module main;

  reg  [3:0] a,b;
  wire c;

  assign c = a && b;
  
  initial  
  begin
    a = 4'd3;
    b = 4'd6;
    #1 ;
    if (c !== 1) 
      begin
        $display(FAILED);
        $finish;
      end
      
    a = 4'd0;
    #1 ;
    if (c !== 0) 
      begin
        $display(FAILED);
        $finish;
      end
      
    b = 4'd0;
    #1 ;
    if (c !== 0) 
      begin
        $display(FAILED);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

