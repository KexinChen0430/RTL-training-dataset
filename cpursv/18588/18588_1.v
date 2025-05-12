
module main;

  reg  [15:0] a,b,c;

  
  initial  
  begin
    a = 1;
    b = 1;
    c = a%b;
    if (c !== 16'd0) 
      begin
        $display("FAILED -- 1 %% 1 == 'b%b",c);
        $finish;
      end
      
    a = 9;
    b = 8;
    c = a%b;
    if (c !== 16'd1) 
      begin
        $display("FAILED -- 9 %% 8 == 'b%b",c);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

