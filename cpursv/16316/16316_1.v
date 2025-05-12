
module memidxrng;

  reg  mem[12:2];
  reg  [7:0] i;
  integer  errs = 0;

  
  initial  
  begin
    for (i = 0; i < 255; i = 1+i)
        mem[i] <= ^i;
    #1 ;
    for (i = 0; i < 17; i = 1+i)
        $display("mem[%d] = %b \%b",i,mem[i],^i);
    if (errs === 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

