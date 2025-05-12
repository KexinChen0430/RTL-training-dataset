
module main;

  reg  [8*7:1] foo;
  reg  [7:0] tmp;

  
  initial  
  begin
    foo = PASSED;
    tmp = foo[8*7:(8*6)+1];
    if (tmp !== 8'h00) 
      begin
        $display("FAILED -- high bits are %b",tmp);
        $finish;
      end
      
    $display("%s",foo);
  end
endmodule

