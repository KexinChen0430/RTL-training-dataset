
module eeq;

  reg  [3:0] a,b;
  wire  eeq = a === b;
  wire  nee = a !== b;
  reg  err;

  
  always 
      begin
        #2 ;
        $display("%b %b ===%b !==%b",a,b,eeq,nee);
        if (((a === b) !== eeq) || ((a !== b) !== nee)) err = 1;
          
      end
  
  initial  
  begin
    err = 0;
    #1 a = 4'bzx10; b = 4'bzx10;
    #1 ;
    #1 a = 4'b1x10; b = 4'bzx10;
    #1 ;
    #1 a = 4'bxz10; b = 4'bzx10;
    #1 ;
    #1 a = 4'bxz01; b = 4'bzx10;
    #1 ;
    #1 a = 4'b0000; b = 4'b0000;
    #1 ;
    #1 a = 4'b1111; b = 4'b1111;
    #1 ;
    #1 a = 4'bxxxx; b = 4'bxxxx;
    #1 ;
    #1 a = 4'bzzzz; b = 4'bzzzz;
    #1 ;
    #1 ;
    if (err) 
      $display(FAILED);
    else 
      $display(PASSED);
    $finish;
  end
endmodule

