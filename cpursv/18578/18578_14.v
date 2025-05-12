
module main;

  parameter  PARM = 2;
  reg  [3:0] b;
  wire [1:0] a;

  assign a = 1+b[3:(3-PARM)+1];
  
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

