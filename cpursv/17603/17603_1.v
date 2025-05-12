
module main;

  reg   clk = 0;

  
  always   #5 clk = ~clk;
  
  initial  
  begin
    $monitor($time,,"clk=%b",clk);
    #61 $finish;
  end
endmodule

