
module test;

  integer I0,I1;
  reg  [15:0] R0,R1;
  reg  [3:0] error;

  
  initial  
  begin
    error = 0;
    I0 = -4'd12;
    I1 = -32'd12;
    if (I0 !== 32'hfffffff4) 
      begin
        $display("FAILED - negative decimal assignment failed. I0 s/b fffffff4, is %h",
                 I0);
        error = 1;
      end
      
    if (I1 !== 32'hfffffff4) 
      begin
        $display("FAILED - negative decimal assignment failed. I1 s/b fffffff4, is %h",
                 I1);
        error = 1;
      end
      
    if (error === 0) 
      $display(PASSED);
      
  end
endmodule

