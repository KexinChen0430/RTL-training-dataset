module StreamFifo ( 
      input   io_push_valid, 
      output  io_push_ready, 
      input  [7:0] io_push_payload, 
      output  io_pop_valid, 
      input   io_pop_ready, 
      output [7:0] io_pop_payload, 
      input   io_flush, 
      output [4:0] io_occupancy, 
      output [4:0] io_availability, 
      input   io_mainClk, 
      input   resetCtrl_systemReset); 
  reg [7:0] _zz_3_; 
  wire [0:0] _zz_4_; 
  wire [3:0] _zz_5_; 
  wire [0:0] _zz_6_; 
  wire [3:0] _zz_7_; 
  wire [3:0] _zz_8_; 
  wire  _zz_9_; 
  reg  _zz_1_; 
  reg  pushPtr_willIncrement; 
  reg  pushPtr_willClear; 
  reg [3:0] pushPtr_valueNext; 
  reg [3:0] pushPtr_value; 
  wire  pushPtr_willOverflowIfInc; 
  wire  pushPtr_willOverflow; 
  reg  popPtr_willIncrement; 
  reg  popPtr_willClear; 
  reg [3:0] popPtr_valueNext; 
  reg [3:0] popPtr_value; 
  wire  popPtr_willOverflowIfInc; 
  wire  popPtr_willOverflow; 
  wire  ptrMatch; 
  reg  risingOccupancy; 
  wire  pushing; 
  wire  popping; 
  wire  empty; 
  wire  full; 
  reg  _zz_2_; 
  wire [3:0] ptrDif; 
  reg [7:0] ram [0:15]; 
endmodule