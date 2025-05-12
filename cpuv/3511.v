module snes_controller
  (
   input                              clk, 
   input                              serial_in, 
   output reg                         data_clk, 
   output reg                         data_latch, 
   output reg [SNES_BUTTON_COUNT-1:0] button_state 
   );