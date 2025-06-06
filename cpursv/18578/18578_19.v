
module main;

  parameter  PARM = 1<<<1;
  reg  [3:0] b;
  wire [1:0] a;

  assign a = b[3:(3+1)+(0-PARM)]+1;
  
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

