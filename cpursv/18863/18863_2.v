
module main();

  wire [31:0] result;
  reg  [31:0] a,b;

  assign result = a | b;
  
  initial  
  begin
    a = 0;
    b = 0;
    #5 ;
    a = 32'haaaaaaaa;
    #5 ;
    b = 32'h55555555;
    #5 ;
  end
  
  initial  
  begin
    #1 ;
    if (result != 32'h0) 
      begin
        $display("FAILED - result not initialized\n");
        $finish;
      end
      
    #5 ;
    if (result != 32'haaaaaaaa) 
      begin
        $display("FAILED - result not updated\n");
        $finish;
      end
      
    #5 ;
    if (result != 32'hffffffff) 
      begin
        $display("FAILED - result not updated\n");
        $finish;
      end
      
    $display(PASSED\n);
    $finish;
  end
endmodule

