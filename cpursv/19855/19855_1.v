
module main;

  reg  [3:0] b;
  wire [1:0] a;

  assign a = 1+b[3:2];
  
  initial  
  begin
    b = 4'b1011;
    #1 ;
    if (a === 2'b11) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

