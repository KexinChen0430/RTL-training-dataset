
module main;

  reg  ena,wea;
  reg  enb,web;
  reg  clk;
  reg   out = 0;

  
  always @(posedge clk)
      begin
        if ((web == 1) && (wea == 1) && (enb == 1) && (ena == 1)) out <= 1;
          
      end
  
  initial  
  begin
    clk = 0;
    ena = 0;
    enb = 0;
    wea = 0;
    web = 0;
    $monitor("clk=%b: ena=%b, enb=%b, wea=%b, web=%b --> out=%b",clk,
             ena,enb,wea,web,out);
    #1 clk = 1;
    #1 clk = 0; ena = 1; enb = 1;
    #1 clk = 1;
    #1 clk = 0; wea = 1; web = 1;
    #1 clk = 1;
    #1 clk = 0;
  end
endmodule

