module wb_ram #
(
    parameter DATA_WIDTH = 32,              
    parameter ADDR_WIDTH = 32,              
    parameter SELECT_WIDTH = (DATA_WIDTH/8) 
)
(
    input  wire                    clk,     
    input  wire [ADDR_WIDTH-1:0]   adr_i,   
    input  wire [DATA_WIDTH-1:0]   dat_i,   
    output wire [DATA_WIDTH-1:0]   dat_o,   
    input  wire                    we_i,    
    input  wire [SELECT_WIDTH-1:0] sel_i,   
    input  wire                    stb_i,   
    output wire                    ack_o,   
    input  wire                    cyc_i    
);