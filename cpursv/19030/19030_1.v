
module main();

  reg  [15:0] a;
  reg  [31:0] b;
  integer result;
  integer int_a;
  integer int_b;

  
  initial  
  begin
    a = 0;
    b = 0;
    result = 0;
    #5 ;
    a = 16'h1234;
    result = a;
    #5 ;
    b = 32'h12345678;
    result = b;
    #5 ;
    int_a = -1;
    int_b = 1;
    result = int_b+int_a;
    #5 ;
    int_a = 0;
    int_b = -1;
    result = int_b+int_a;
  end
  
  initial  
  begin
    #1 ;
    #5 ;
    if (result != 32'h00001234) 
      begin
        $display("FAILED - Bit extend wrong\n");
        $finish;
      end
      
    #5 ;
    if (result != 32'h12345678) 
      begin
        $display("FAILED - 32 bit assign wrong\n");
        $finish;
      end
      
    #5 ;
    if (result != 32'h00000000) 
      begin
        $display("FAILED - -1 + 1 = %h\n",result);
        $finish;
      end
      
    #5 ;
    if (result != 32'hffffffff) 
      begin
        $display("FAILED - 0 - 1 = %h\n",result);
        $finish;
      end
      
    $display(PASSED\n);
    $finish;
  end
endmodule

