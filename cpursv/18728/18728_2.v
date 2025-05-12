
module main;

  realtime  x;
  real  a3,a4;

  
  initial  
  begin
    a3 = 0.3;
    a4 = 0.4;
    x = a3+(2*a4);
    $display("a3 = %f, a4 = %f, x = %f",a3,a4,x);
    if (x > 1.1001) 
      begin
        $display(FAILED);
        $finish;
      end
      
    if (x < 1.0999) 
      begin
        $display(FAILED);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

