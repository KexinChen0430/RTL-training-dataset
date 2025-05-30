module mig(
    inout [15:0] ddr2_dq,           
    inout [1:0] ddr2_dqs_n,         
    inout [1:0] ddr2_dqs_p,         
    output [12:0] ddr2_addr,        
    output [2:0] ddr2_ba,           
    output ddr2_ras_n,              
    output ddr2_cas_n,              
    output ddr2_we_n,               
    output [0:0] ddr2_ck_p,         
    output [0:0] ddr2_ck_n,         
    output [0:0] ddr2_cke,          
    output [0:0] ddr2_cs_n,         
    output [1:0] ddr2_dm,           
    output [0:0] ddr2_odt,          
    input sys_clk_i,                
    input [26:0] app_addr,          
    input [2:0] app_cmd,            
    input app_en,                   
    input [127:0] app_wdf_data,     
    input app_wdf_end,              
    input [15:0] app_wdf_mask,      
    input app_wdf_wren,             
    output [127:0] app_rd_data,     
    output app_rd_data_end,         
    output app_rd_data_valid,       
    output app_rdy,                 
    output app_wdf_rdy,             
    input app_sr_req,               
    input app_ref_req,              
    input app_zq_req,               
    output app_sr_active,           
    output app_ref_ack,             
    output app_zq_ack,              
    output ui_clk,                  
    output ui_clk_sync_rst,         
    output init_calib_complete,     
    input [11:0] device_temp_i,     
    input sys_rst                   
);
;
endmodule