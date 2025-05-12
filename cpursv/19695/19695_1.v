
module test;

  reg  [4:1] a;
  reg  [1:4] b;
  integer i;

  
  initial  
  begin
    a = 4'b1100;
    for (i = 1; i <= 4; i = i+1)
        b[i] = a[i];
    $display("a=%b, b=%b",a,b);
    if (b !== 4'b0011) 
      begin
        $display("FAILED -- b == %b",b);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

