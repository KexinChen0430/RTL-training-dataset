
module baudgen(input  wire clk,
               input  wire resetq,
               input  wire [31:0] baud,
               input  wire restart,
               output wire ser_clk);

  parameter  CLKFREQ = 1000000;
  parameter  RWIDTH = 25;
  wire [RWIDTH+(0-1):0]  aclkfreq = CLKFREQ;
  reg  [RWIDTH+(0-1):0] d;
  wire [RWIDTH+(0-1):0] 
       dInc = d[RWIDTH+(0-1)] ? {4'd0,baud} : ((0-aclkfreq)+{4'd0,baud});
  wire [RWIDTH+(0-1):0]  dN = restart ? 0 : (dInc+d);
  wire  fastclk = ~d[RWIDTH+(0-1)];

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

