
module main;

  wire [3:0] b;
  reg  [1:0] a;
  reg  c;

  assign b = c<<a;
  
  initial  
  begin
    #1 ;
    c = 1'b1;
    a = 2'd2;
    #1 ;
    if (b === 4'b0100) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

