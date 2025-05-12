module srl_fifo #
(
    parameter WIDTH = 8,
    parameter DEPTH = 16
)
(
    input  wire                       clk,        
    input  wire                       rst,        
    input  wire                       write_en,   
    input  wire [WIDTH-1:0]           write_data, 
    input  wire                       read_en,    
    output wire [WIDTH-1:0]           read_data,  
    output wire                       full,       
    output wire                       empty,      
    output wire [$clog2(DEPTH+1)-1:0] count       
);