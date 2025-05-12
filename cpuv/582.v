module axi_protocol_converter_v2_1_b_downsizer #
  (
   parameter         C_FAMILY                         = "none", 
   parameter integer C_AXI_ID_WIDTH                   = 4,      
   parameter integer C_AXI_SUPPORTS_USER_SIGNALS      = 0,      
   parameter integer C_AXI_BUSER_WIDTH                = 1       
   )
  (
   input  wire                                                    ARESET, 
   input  wire                                                    ACLK,   
   input  wire                              cmd_valid,  
   input  wire                              cmd_split,  
   input  wire [4-1:0]                      cmd_repeat, 
   output wire                              cmd_ready,  
   output wire [C_AXI_ID_WIDTH-1:0]         S_AXI_BID,    
   output wire [2-1:0]                      S_AXI_BRESP,  
   output wire [C_AXI_BUSER_WIDTH-1:0]      S_AXI_BUSER,  
   output wire                              S_AXI_BVALID, 
   input  wire                              S_AXI_BREADY, 
   input  wire [C_AXI_ID_WIDTH-1:0]         M_AXI_BID,    
   input  wire [2-1:0]                      M_AXI_BRESP,  
   input  wire [C_AXI_BUSER_WIDTH-1:0]      M_AXI_BUSER,  
   input  wire                              M_AXI_BVALID, 
   output wire                              M_AXI_BREADY  
   );
  localparam [2-1:0] C_RESP_OKAY        = 2'b00; 
  localparam [2-1:0] C_RESP_EXOKAY      = 2'b01; 
  localparam [2-1:0] C_RESP_SLVERROR    = 2'b10; 
  localparam [2-1:0] C_RESP_DECERR      = 2'b11; 
  wire                            cmd_ready_i;        
  wire                            pop_mi_data;        
  wire                            mi_stalling;        
  reg  [4-1:0]                    repeat_cnt_pre;     
  reg  [4-1:0]                    repeat_cnt;         
  wire [4-1:0]                    next_repeat_cnt;    
  reg                             first_mi_word;      
  wire                            last_word;          
  wire                            load_bresp;         
  wire                            need_to_update_bresp; 
  reg  [2-1:0]                    S_AXI_BRESP_ACC;    
  wire                            M_AXI_BREADY_I;     
  wire [C_AXI_ID_WIDTH-1:0]       S_AXI_BID_I;        
  reg  [2-1:0]                    S_AXI_BRESP_I;      
  wire [C_AXI_BUSER_WIDTH-1:0]    S_AXI_BUSER_I;      
  wire                            S_AXI_BVALID_I;     
  wire                            S_AXI_BREADY_I;     
endmodule