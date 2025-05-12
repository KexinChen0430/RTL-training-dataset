
module main;

  reg  [1:0] a[3:0];
  reg  [1:0]  s = 0;
  wire [1:0]  b = a[s];

  
  initial  
  begin
    a[0] = 3;
    a[1] = 2;
    a[2] = 1;
    a[3] = 0;
  end
  
  initial  
  begin
    #1 
      if (b !== 3) 
        begin
          $display("FAILED -- s=%b, b=%b",s,b);
          $finish;
        end
        

    s = 1;
    #1 
      if (b !== 2) 
        begin
          $display("FAILED -- s=%b, b=%b",s,b);
          $finish;
        end
        

    s = 2;
    #1 
      if (b !== 1) 
        begin
          $display("FAILED -- s=%b, b=%b",s,b);
          $finish;
        end
        

    s = 3;
    #1 
      if (b !== 0) 
        begin
          $display("FAILED -- s=%b, b=%b",s,b);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

