
module counter_rollover2  #(parameter  W = 8, N = 1<<1)
  (input  wire CLK,
   input  wire ENABLE,
   input  wire LOAD,
   input  wire [W-1:0] DI,
   output wire [W-1:0] DO);

  reg  [(0-1)+(W*(1/1<<1)):0] CounterMSB;
  reg  [(0-1)+(W*(1/1<<1)):0] CounterLSB;
  wire  TerminalCount = &CounterLSB;
  wire  RollOver = ENABLE & TerminalCount;

  
  always @(posedge CLK)
      if (LOAD) CounterMSB <= DI[W-1:W*(1/1<<1)];
      else if (RollOver) CounterMSB <= CounterMSB+1;
        
  
  always @(posedge CLK)
      if (LOAD) CounterLSB <= DI[(0-1)+(W*(1/1<<1)):0];
      else if (ENABLE) CounterLSB <= 1+CounterLSB;
        
  assign DO = {CounterMSB,CounterLSB};
endmodule

