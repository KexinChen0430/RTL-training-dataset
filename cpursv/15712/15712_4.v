
module omsp_clock_gate(gclk,clk,enable,scan_enable);

  output gclk;
  input  clk;
  input  enable;
  input  scan_enable;
  wire  enable_in = scan_enable | enable;
  reg  enable_latch;

  
  always @(clk or enable_in)
      if (~clk) enable_latch <= enable_in;
        
  assign gclk = clk & enable_latch;
endmodule

