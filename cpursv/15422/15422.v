
module target(input  wire clk);

  parameter  number = 999;

  
  always @(posedge clk)
      $display("%m: number=%0d",number);
endmodule

