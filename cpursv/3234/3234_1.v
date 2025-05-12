
module clk25khz(input  wire clk,
                input  wire en,
                output wire outclk);

  reg  [10:0]  cnt = 0;

  assign outclk = (cnt == 2000) & en;
  
  always @(posedge clk)
      if (outclk) cnt <= 0;
      else cnt <= cnt+11'b1;
endmodule

