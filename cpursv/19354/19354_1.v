
module test;

  reg  [15:0] is[1:0];
  reg  [4:0] i;

  
  initial  
  begin
    i = 0;
    is[0] = i;
    if (is[0] !== 16'd0) 
      begin
        $display("FAILED -- is[0] --> %b",is[0]);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

