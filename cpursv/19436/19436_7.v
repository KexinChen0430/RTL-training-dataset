
module main();

  reg  ['b110+'d4:0] val1;
  reg  [10'h1+'d9:0] val2;

  
  initial  
  begin
    val1 = 11'h1+'d4;
    val2 = 11'h2+6;
    if ((val2 === 11'h8) && (val1 === 11'h5)) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

