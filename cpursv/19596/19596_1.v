
module main;

  reg  [3:0] r;
  reg  [3:0] a;
  reg  [4:0] b;
  reg  f;

  
  initial  
  begin
    a = 4'b1010;
    b = 5'b10101;
    f = 1;
    r = f ? a : b;
    if (r !== 4'b1010) 
      begin
        $display("FAILED: r === %b",r);
        $finish;
      end
      
    f = 0;
    r = f ? a : b;
    if (r !== 4'b0101) 
      begin
        $display("FAILED: r === %b",r);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

