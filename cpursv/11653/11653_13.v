
module counter_rollover2  #(parameter  W = 8, N = 2)
  (input  wire CLK,
   input  wire ENABLE,
   input  wire LOAD,
   input  wire [(-1)+W:0] DI,
   output wire [(-1)+W:0] DO);

  reg  [(W/2)-1:0] CounterMSB;
  reg  [(W/2)-1:0] CounterLSB;
  wire  TerminalCount = &CounterLSB;
  wire  RollOver = TerminalCount & ENABLE;

  
  always @(posedge CLK)
      if (LOAD) CounterMSB <= DI[(-1)+W:W/2];
      else if (RollOver) CounterMSB <= 1+CounterMSB;
        
  
  always @(posedge CLK)
      if (LOAD) CounterLSB <= DI[(W/2)-1:0];
      else if (ENABLE) CounterLSB <= CounterLSB+1;
        
  assign DO = {CounterMSB,CounterLSB};
endmodule

