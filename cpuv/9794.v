module tg_prbs_gen # 
(
  parameter PRBS_WIDTH = 64, 
  parameter START_ADDR  = 32'h00000000, 
  parameter DMODE = "READ", 
  parameter PRBS_OFFSET = 0, 
  parameter [PRBS_WIDTH-1:0] TAPS= 32'h80200003 
)
(
 input           clk_i, 
 input           clk_en, 
 input           rst, 
 input [PRBS_WIDTH-1:0]    prbs_seed_i, 
 output                    initialize_done, 
 output  [PRBS_WIDTH-1:0]  prbs_o, 
 output reg [3:0] prbs_shift_value, 
 output [31:0] ReSeedcounter_o 
);