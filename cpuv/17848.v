module flash16 (
    input           wb_clk_i,       
    input           wb_rst_i,       
    input  [15:0]   wb_dat_i,       
    output [15:0]   wb_dat_o,       
    input           wb_we_i,        
    input           wb_adr_i,       
    input  [ 1:0]   wb_sel_i,       
    input           wb_stb_i,       
    input           wb_cyc_i,       
    output          wb_ack_o,       
    output [21:0] flash_addr_,      
    input  [15:0] flash_data_,      
    output        flash_we_n_,      
    output        flash_oe_n_,      
    output        flash_ce_n_,      
    output        flash_rst_n_      
);
wire        op;                    
wire        wr_command;            
reg  [21:0] address;               
assign op = wb_stb_i & wb_cyc_i;   
assign flash_rst_n_ = 1'b1;        
assign flash_we_n_  = 1'b1;        
assign flash_oe_n_  = !op;         
assign flash_ce_n_  = !op;         
assign flash_addr_  = address;     
assign wr_command   = op & wb_we_i; 
assign wb_ack_o = op;              
assign wb_dat_o = flash_data_;     
`define FLASH_ALO   1'h0            
`define FLASH_AHI   1'h1            
always @(posedge wb_clk_i)          
    if(wb_rst_i)
        address <= 22'h000000;      
    else
        if(wr_command)              
            case(wb_adr_i)          
                `FLASH_ALO: address[15: 0] <= wb_dat_i; 
                `FLASH_AHI: address[21:16] <= wb_dat_i[5:0]; 
                default:    ;         
            endcase                 
endmodule 