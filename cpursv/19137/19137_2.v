
module main;

  reg  [7:0] a;
  reg  x,y;
  reg  error;

  
  initial  
  begin
    error = 0;
    for (a = 0; a < 32; a = a+1)
        begin
          x = a[0] ? a[1] : 
              a[2] ? a[3] : a[4];
          y = a[0] ? a[1] : 
              a[2] ? a[3] : a[4];
          if (x != y) 
            begin
              $display("FAILED  a=%b, x=%b != y=%b",a[4:0],x,y);
              error = 1;
            end
            
        end
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

