
module clk_reset_gen(clk,reset);

  output clk;
  output reset;
  reg  clk;
  reg  reset;

  
  initial  
  begin
    reset = 1;
    #5 ;
    clk = 0;
    #5 ;
    clk = 1;
    #5 ;
    reset = 0;
    clk = 0;
    forever #5 clk = ~clk;
  end
endmodule

