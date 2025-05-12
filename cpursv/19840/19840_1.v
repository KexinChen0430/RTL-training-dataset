
module main;

  reg  [3:0] a;
  wire [3:0] b;

  assign b = ~a;
  
  initial  
  begin
    a = 4'b0110;
    #1 ;
    if (b === 4'b1001) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

