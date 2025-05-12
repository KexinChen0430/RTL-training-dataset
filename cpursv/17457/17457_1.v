
module memidxrng;

  reg  mem[12:2];
  reg  [7:0] i;
  integer  errs = 0;

  
  initial  
  begin
    for (i = 0; i < 255; i = i+1)
        mem[i] <= ^i;
    #1 ;
    for (i = 0; i < 17; i = i+1)
        $display("mem[%d] = %b \%b",i,mem[i],^i);
    if (mem[13] !== 1'bx) 
      begin
        $display("FAILED: mem[13] = %b, expect x",mem[14]);
        errs = errs+1;
      end
      
    if (mem[1] !== 1'bx) 
      begin
        $display("FAILED: mem[1] = %b, expect x",mem[1]);
        errs = errs+1;
      end
      
    if (errs === 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

