module StreamFifoLowLatency (
  input               io_push_valid,         
  output              io_push_ready,         
  input               io_push_payload_error, 
  input      [31:0]   io_push_payload_inst,  
  output reg          io_pop_valid,          
  input               io_pop_ready,          
  output reg          io_pop_payload_error,  
  output reg [31:0]   io_pop_payload_inst,   
  input               io_flush,              
  output     [0:0]    io_occupancy,          
  input               clk,                   
  input               reset                  
);