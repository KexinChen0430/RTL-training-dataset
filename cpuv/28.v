module axi_protocol_converter_v2_1_w_axi3_conv #
  (
   parameter C_FAMILY                            = "none", 
   parameter integer C_AXI_ID_WIDTH              = 1,      
   parameter integer C_AXI_ADDR_WIDTH            = 32,     
   parameter integer C_AXI_DATA_WIDTH            = 32,     
   parameter integer C_AXI_SUPPORTS_USER_SIGNALS = 0,      
   parameter integer C_AXI_WUSER_WIDTH           = 1,      
   parameter integer C_SUPPORT_SPLITTING         = 1,      
   parameter integer C_SUPPORT_BURSTS            = 1       
   )
  (
   input wire ACLK,       
   input wire ARESET,     
   input  wire                              cmd_valid,   
   input  wire [C_AXI_ID_WIDTH-1:0]         cmd_id,      
   input  wire [4-1:0]                      cmd_length,  
   output wire                              cmd_ready,   
   input  wire [C_AXI_DATA_WIDTH-1:0]   S_AXI_WDATA,   
   input  wire [C_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,   
   input  wire                          S_AXI_WLAST,   
   input  wire [C_AXI_WUSER_WIDTH-1:0]  S_AXI_WUSER,   
   input  wire                          S_AXI_WVALID,  
   output wire                          S_AXI_WREADY,  
   output wire [C_AXI_ID_WIDTH-1:0]     M_AXI_WID,     
   output wire [C_AXI_DATA_WIDTH-1:0]   M_AXI_WDATA,   
   output wire [C_AXI_DATA_WIDTH/8-1:0] M_AXI_WSTRB,   
   output wire                          M_AXI_WLAST,   
   output wire [C_AXI_WUSER_WIDTH-1:0]  M_AXI_WUSER,   
   output wire                          M_AXI_WVALID,  
   input  wire                          M_AXI_WREADY   
   );
  reg                             first_mi_word;       
  reg  [8-1:0]                    length_counter_1;    
  reg  [8-1:0]                    length_counter;      
  wire [8-1:0]                    next_length_counter; 
  wire                            last_beat;           
  wire                            last_word;           
  wire                            cmd_ready_i;         
  wire                            pop_mi_data;         
  wire                            mi_stalling;         
  wire                            S_AXI_WREADY_I;      
  wire [C_AXI_ID_WIDTH-1:0]       M_AXI_WID_I;         
  wire [C_AXI_DATA_WIDTH-1:0]     M_AXI_WDATA_I;       
  wire [C_AXI_DATA_WIDTH/8-1:0]   M_AXI_WSTRB_I;       
  wire                            M_AXI_WLAST_I;       
  wire [C_AXI_WUSER_WIDTH-1:0]    M_AXI_WUSER_I;       
  wire                            M_AXI_WVALID_I;      
  wire                            M_AXI_WREADY_I;      
endmodule