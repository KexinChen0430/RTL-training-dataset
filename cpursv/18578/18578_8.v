
module main;

  parameter  PARM = 1<<<1;
  reg  [3:0] b;
  wire [1:0] a;

  assign a = 1+b[3:1+(3-PARM)];
  
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

