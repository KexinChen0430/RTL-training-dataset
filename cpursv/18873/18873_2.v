
module oh_edgealign(firstedge,fastclk,slowclk);

  input  fastclk;
  input  slowclk;
  output firstedge;
  reg  clk45;
  reg  clk90;
  reg  firstedge;

  
  always @(negedge fastclk)  clk45 <= slowclk;
  
  always @(posedge fastclk)
      begin
        clk90 <= clk45;
        firstedge <= clk90 & ~clk45;
      end
endmodule

