
module test;

  reg  [7:0] x;

  
  initial  
  begin
    x = 'h4000+'hzz;
    if (x !== 8'hxx) 
      begin
        $display("FAILED -- x = %b",x);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

