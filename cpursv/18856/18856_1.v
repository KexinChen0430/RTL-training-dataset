
module main();

  reg  clock;
  reg  q;
  reg  reset;
  reg  error;

  
  always @(posedge clock or posedge reset)
      begin : FF
        #2 ;
        if (reset) q <= 0;
        else q <= ~q;
      end
  
  initial  
  begin
    error = 0;
    clock = 0;
    reset = 1;
    #4 ;
    if (q != 1'b0) 
      begin
        $display("FAILED - disable3.6A - Flop didn't clear on clock & reset");
        error = 1;
      end
      
    reset = 1'b0;
    clock = 1'b1;
    #3 ;
    if (q != 1'b1) 
      begin
        $display("FAILED - disable3.6A - Flop didn't set on clock");
        error = 1;
      end
      
    clock = 1'b0;
    #3 ;
    clock = 1'b1;
    #1 ;
    disable FF;
    #2 ;
    if (q != 1'b1) 
      begin
        $display("FAILED - disable3.6A - Disable didn't stop FF toggle");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

