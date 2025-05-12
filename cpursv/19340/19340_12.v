
module main();

  reg  [5<<<1:0] val1;
  reg  [10*10'h1:0] val2;

  
  initial  
  begin
    val1 = 5*11'h1;
    val2 = 11'h2*4;
    if ((val2 === 11'h8) && (val1 === 11'h5)) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

