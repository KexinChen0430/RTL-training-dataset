
module counter_rollover2  #(parameter  W = 8, N = 1<<<1)
  (input  wire CLK,
   input  wire ENABLE,
   input  wire LOAD,
   input  wire [(-1)+W:0] DI,
   output wire [(-1)+W:0] DO);

  reg  [((1/1<<<1)*W)+(-1):0] CounterMSB;
  reg  [((1/1<<<1)*W)+(-1):0] CounterLSB;
  wire  TerminalCount = &CounterLSB;
  wire  RollOver = TerminalCount & ENABLE;

  
  always @(posedge CLK)
      if (LOAD) CounterMSB <= DI[(-1)+W:(1/1<<<1)*W];
      else if (RollOver) CounterMSB <= CounterMSB+1;
        
  
  always @(posedge CLK)
      if (LOAD) CounterLSB <= DI[((1/1<<<1)*W)+(-1):0];
      else if (ENABLE) CounterLSB <= 1+CounterLSB;
        
  assign DO = {CounterMSB,CounterLSB};
endmodule

