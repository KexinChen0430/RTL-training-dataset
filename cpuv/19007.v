module main (); 
reg x,clock; 
reg inval; 
reg error; 
always @(posedge clock)
  begin
    x <= ~inval; 
    x <= inval; 
  end
initial
  begin
    clock = 0; 
    error = 0; 
    #1; 
    inval = 0; 
    #5 ; 
    clock = 1; 
    #1 ; 
    if(x !== inval)
      begin
        $display("FAILED - parallel non-blocking assign s/b 0, is %b",x);
        error = 1;
      end
    #6 
    clock = 0; 
    #1 ; 
    inval = 1; 
    #5 ; 
    clock = 1; 
    #1 ; 
    if(x !== inval)
      begin
        $display("FAILED - parallel non-blocking assign s/b 1, is %b",x);
        error = 1;
      end
    #1 ; 
    if(error == 0)
       $display("PASSED");
  end
endmodule 