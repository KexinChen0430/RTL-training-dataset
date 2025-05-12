
module main;

  reg  [7:0] a;
  reg  [6:-1] b;

  
  initial  
  begin
    a = 1;
    b = 2;
    if (a !== 8'h01) 
      begin
        $display("FAILED -- to initialize a: %b",a);
        $finish;
      end
      
    if (b !== 8'h02) 
      begin
        $display("FAILED -- to initialize b: %b",b);
        $finish;
      end
      
    b = a;
    if (b !== 8'h01) 
      begin
        $display("FAILED -- to copy a to b: %b",b);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

