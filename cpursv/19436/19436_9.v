
module main();

  reg  ['d4+'b110:0] val1;
  reg  ['d9+10'h1:0] val2;

  
  initial  
  begin
    val1 = 'd4+11'h1;
    val2 = 6+11'h2;
    if ((val2 === 11'h8) && (val1 === 11'h5)) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

