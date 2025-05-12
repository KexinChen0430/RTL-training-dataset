
module ps(input  printclk);

  
  always @(posedge printclk)
      $write("[%0t] %m: Clocked\n",$time);
endmodule

