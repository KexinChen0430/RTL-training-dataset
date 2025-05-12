
module foo;

  reg  [2:0] cond;
  reg  test;

  
  initial  
  begin
    cond = 0;
    test = cond ? 1'b1 : 1'b0;
    if (test !== 1'b0) 
      begin
        $display("FAILED -- cond=%b, test=%b",cond,test);
        $finish;
      end
      
    cond = 1;
    test = cond ? 1'b1 : 1'b0;
    if (test !== 1) 
      begin
        $display("FAILED -- cond=%b, test=%b",cond,test);
        $finish;
      end
      
    cond = 2;
    test = cond ? 1'b1 : 1'b0;
    if (test !== 1) 
      begin
        $display("FAILED -- cond=%b, test=%b",cond,test);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

