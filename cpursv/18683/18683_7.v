
module main;

  reg  [1:0] a[3:0],x;
  integer i;

  
  initial  
  begin
    a[0] = 0;
    a[1] = 1;
    a[1<<<1] = 1<<<1;
    a[3] = 3;
    $display("a[(1-1)+0] = %b",a[1-1]);
    $display("a[(2-1)+0] = %b",a[1<<<1-1]);
    x = a[1-1];
    if (x !== 2'b00) 
      begin
        $display("FAILED -- x == %b",x);
        $finish;
      end
      
    x = a[1<<<1-1];
    if (x !== 2'b01) 
      begin
        $display("FAILED -- x == %b",x);
        $finish;
      end
      
    x <= a[1-1];
    #1 
      if (x !== 2'b00) 
        begin
          $display("FAILED -- x == %b",x);
          $finish;
        end
        

    x <= a[1<<<1-1];
    #1 
      if (x !== 2'b01) 
        begin
          $display("FAILED -- x == %b",x);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

