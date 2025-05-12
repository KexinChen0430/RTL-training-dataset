
module Mem1D(input  clock,
             input  [3:0] io_w_addr,
             input  [31:0] io_w_data,
             input  io_w_en,
             input  [3:0] io_r_addr,
             output [31:0] io_output_data);

  reg  [31:0] _T_14[0:15];
  reg  [31:0] _RAND_0;
  wire [31:0] _T_14__T_17_data;
  wire [3:0] _T_14__T_17_addr;
  wire [31:0] _T_14__T_16_data;
  wire [3:0] _T_14__T_16_addr;
  wire _T_14__T_16_mask;
  wire _T_14__T_16_en;

  assign _T_14__T_17_addr = io_r_addr;
  assign _T_14__T_17_data = _T_14[_T_14__T_17_addr];
  assign _T_14__T_16_data = io_w_data;
  assign _T_14__T_16_addr = io_w_addr;
  assign _T_14__T_16_mask = io_w_en;
  assign _T_14__T_16_en = io_w_en;
  assign io_output_data = _T_14__T_17_data;
  
  always @(posedge clock)
      begin
        if (_T_14__T_16_mask & _T_14__T_16_en) 
          begin
            _T_14[_T_14__T_16_addr] <= _T_14__T_16_data;
          end
          
      end
endmodule

