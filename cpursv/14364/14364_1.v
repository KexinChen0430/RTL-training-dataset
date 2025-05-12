
module bug27067;

  
  initial    $monitor("%T %b %b %b",$time,clk1,clko1,clko2);
  
  initial    forever @(negedge clk1)  dclk1ff <= #50 ~dclk1ff;
endmodule

