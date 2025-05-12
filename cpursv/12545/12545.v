
module TestInitializer  #(parameter  WAIT_TIME = 100, V_WAIT_TIME = WAIT_TIME)
  (input  clk_i,
   input  done,
   input  rst_i,
   output reg start);

  
  initial  
  begin
    start = 0;
    @(posedge rst_i)  ;
    start = 1;
    @(posedge clk_i)  ;
    @(posedge clk_i)  ;
    @(posedge clk_i)  ;
    start = 0;
    #V_WAIT_TIME 
      if (done == 1'b0) 
        $display("not done!");
      else 
        $display("done high");

    $stop;
  end
endmodule

