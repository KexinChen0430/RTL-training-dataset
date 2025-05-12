module dcache_if_pmem_fifo
#(
    parameter WIDTH   = 8,  
    parameter DEPTH   = 4,  
    parameter ADDR_W  = 2   
)
(
     input               clk_i,          
     input               rst_i,          
     input  [WIDTH-1:0]  data_in_i,      
     input               push_i,         
     input               pop_i,          
     output [WIDTH-1:0]  data_out_o,     
     output              accept_o,       
     output              valid_o         
);