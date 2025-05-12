
module InstrumentationCounter(input  clock,
                              input  reset,
                              input  io_enable,
                              output [63:0] io_count);

  reg  [63:0] ff;
  reg  [63:0] _RAND_0;
  wire [64:0] _T_7;
  wire [63:0] _T_8;
  wire [63:0] _T_9;

  assign _T_7 = ff+64'h1;
  assign _T_8 = _T_7[63:0];
  assign _T_9 = io_enable ? _T_8 : ff;
  assign io_count = ff;
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            ff <= 64'h0;
          end
        else 
          begin
            if (io_enable) 
              begin
                ff <= _T_8;
              end
              
          end
      end
endmodule

