
module stimulus;

  reg  [9:0] foo;

  
  initial  
  begin
    foo <= 0-155;
    #1000 
      if (foo !== 10'h365) 
        begin
          $display("FAILED -- foo = %b",foo);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

