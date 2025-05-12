
module test;

  reg  [3:0] val,y;

  
  initial  
  begin
    val = 2;
    y = !val;
    if (y !== 4'b0000) 
      begin
        $display("FAILED -- !%b --> %b",val,y);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

