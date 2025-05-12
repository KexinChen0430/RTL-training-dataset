module wb_sram32 #( 
        parameter                  adr_width = 19, 
        parameter                  latency   = 2    
) (
        input                      clk, 
        input                      reset, 
        input                      wb_stb_i, 
        input                      wb_cyc_i, 
        output reg                 wb_ack_o, 
        input                      wb_we_i, 
        input               [31:0] wb_adr_i, 
        input                [3:0] wb_sel_i, 
        input               [31:0] wb_dat_i, 
        output reg          [31:0] wb_dat_o, 
        output reg [adr_width-1:0] sram_adr, 
        inout               [31:0] sram_dat, 
        output reg           [1:0] sram_be_n,    
        output reg                 sram_ce_n,    
        output reg                 sram_oe_n,    
        output reg                 sram_we_n     
);