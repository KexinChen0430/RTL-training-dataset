
module FF_7(input  clock,
            input  reset,
            input  io_in,
            input  io_init,
            output io_out,
            input  io_enable);

  wire d;
  reg  ff;
  reg  [31:0] _GEN_0;
  wire _T_13;
  wire _GEN_1;

  assign io_out = ff;
  assign d = _GEN_1;
  assign _T_13 = io_enable == 1'h0;
  assign _GEN_1 = _T_13 ? ff : io_in;
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            ff <= io_init;
          end
        else 
          begin
            ff <= d;
          end
      end
endmodule

