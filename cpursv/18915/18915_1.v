
module test;

  wire a;
  reg  b;

  assign #10 a = b;
  
  initial  
  begin
    b = 0;
    #20 b = 1;
    #5 
      if (a !== 0) 
        begin
          $display("FAILED -- a is %b",a);
          $finish;
        end
        

    #6 
      if (a !== 1) 
        begin
          $display("FAILED -- a is %b, should be 1",a);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

