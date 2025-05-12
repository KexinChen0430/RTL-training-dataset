
module baudgen(input  wire clk,
               input  wire resetq,
               input  wire [31:0] baud,
               input  wire restart,
               output wire ser_clk);

  parameter  CLKFREQ = 1000000;
  parameter  RWIDTH = 25;
  wire [(-1)+RWIDTH:0]  aclkfreq = CLKFREQ;
  reg  [(-1)+RWIDTH:0] d;
  wire [(-1)+RWIDTH:0] 
       dInc = d[(-1)+RWIDTH] ? {4'd0,baud} : ({4'd0,baud}-aclkfreq);
  wire [(-1)+RWIDTH:0]  dN = restart ? 0 : (dInc+d);
  wire  fastclk = ~d[(-1)+RWIDTH];

  assign ser_clk = fastclk;
  
  always @(negedge resetq or posedge clk)
      begin
        if (!resetq) 
          begin
            d <= 0;
          end
        else 
          begin
            d <= dN;
          end
      end
endmodule

