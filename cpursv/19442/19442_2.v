
module main;

  reg  [3:0] a;
  reg  [4:0] result,b;

  
  initial  
  begin
    a = 5;
    b = 6;
    result = a+b>>1;
    if (result !== 5) 
      begin
        $display("FAILED: result === %b",result);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

