
module main();

  reg  [5<<1:0] val1;
  reg  [10'h1*10:0] val2;

  
  initial  
  begin
    val1 = 11'h1*5;
    val2 = 4*11'h2;
    if ((val2 === 11'h8) && (val1 === 11'h5)) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

