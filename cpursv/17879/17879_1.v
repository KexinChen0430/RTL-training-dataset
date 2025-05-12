
module at_the_start;

  reg  clk;

  
  always 
      begin
        #5 clk = 0;
        #5 clk = 1;
      end
  wire [3:0] grant_vector;

  reg  [3:0] req_vector;

  reg  enable;

  reg  reset;

  arbiter_LRU4 arb(grant_vector,req_vector,enable,clk,reset);
  
  initial  
  begin
    $display($time," << Starting the simulation >>");
    reset = 1;
    enable = 0;
    req_vector = 4'b1010;
    @(posedge clk)  ;
    #1 ;
    reset = 0;
    enable = 0;
    req_vector = 4'b1110;
    @(posedge clk)  ;
    #1 ;
    reset = 0;
    enable = 1;
    req_vector = 4'b1111;
    #20 ;
    $display($time," << Finishing the simulation >>");
    $finish;
  end
endmodule

