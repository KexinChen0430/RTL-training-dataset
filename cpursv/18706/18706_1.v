
module main;

  reg  c;
  reg  [3:0] a,b;
  wire [3:0] d;

  assign d = c ? a : b;
  
  initial  
  begin
    a = 4'd5;
    b = 4'd6;
    c = 0;
    #1 ;
    if (d !== 4'd6) 
      begin
        $display(FAILED);
        $finish;
      end
      
    c = 1;
    #1 ;
    if (d !== 4'd5) 
      begin
        $display(FAILED);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

