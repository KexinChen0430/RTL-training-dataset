module ft245_sync_if
  #(
    parameter DEBUG=0,            
    parameter EXTRA_READ_GUARD=0, 
    parameter FAST_WRITE_OLD=0,   
    parameter USE_STATE_RESET=0)  
   (
    inout [7:0] adbus_io,         
    input  rxf_n_i,               
    input  txe_n_i,               
    output rd_n_o,                
    output wr_n_o,                
    input  clk_i,                 
    output oe_n_o,                
    output siwu_o,                
    input rst_i,                  
    input [7:0] tx_data_i,        
    input tx_empty_i,             
    output tx_read_o,             
    output [7:0] rx_data_o,       
    output rx_valid_o,            
    input rx_full_i);             
`include "ft245_sync_if.v"       
endmodule