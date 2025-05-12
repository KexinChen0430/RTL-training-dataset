
module mangle;

  reg  \abc;
  reg  "\`~!-_=+\|[]{};:'"",./<>?";
  reg  cde;

  
  initial  
  begin
    abc <= 1;
    "\`~!-_=+\|[]{};:'"",./<>?" <= 1;
    \cde <= 1;
    $display(PASSED);
    $finish;
  end
endmodule

