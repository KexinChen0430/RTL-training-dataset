
module top;

  reg  [119:110] r163;
  reg  [192:162] r222;

  
  initial  
  begin
    r163 = 10'h17d;
    r222 = (1'b1+(^r163 < 4'h8) && 22'h3a15) != 1'bx;
    if (r222 !== 31'b0x) 
      $display("FAILED -- r222=%b",r222);
    else 
      $display(PASSED);
  end
endmodule

