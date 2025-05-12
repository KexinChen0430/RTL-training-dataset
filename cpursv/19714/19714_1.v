
module main;

  reg  a,b,c,d;
  reg  control;
  reg  clock;
  reg  error;

  
  always @(posedge clock)  {a,b,c,d} = 4'h3;
  
  always @(control)
      if (control) assign {a,b,c,d} = 4'h2;
      else 
        deassign {a,b,c,d};
  
  always 
      begin
        #2 ;
        clock = ~clock;
      end
  
  initial  
  begin
    clock = 0;
    error = 0;
    #3 ;
    if ({a,b,c,d} !== 3) 
      begin
        $display("FAILED - assign3.2D - procedural assignment(1)");
        error = 1;
      end
      
    #2 ;
    control = 1;
    #1 ;
    if ({a,b,c,d} !== 2) 
      begin
        $display("FAILED - assign3.2D - procedural assignment(2)");
        error = 1;
      end
      
    #3 ;
    control = 0;
    #2 ;
    if ({a,b,c,d} !== 3) 
      begin
        $display("FAILED - assign3.2D - procedural assignment(3)");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

