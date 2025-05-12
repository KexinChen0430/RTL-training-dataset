module contact_discovery_results_out_m_axi_buffer
#(parameter
    MEM_STYLE  = "block", 
    DATA_WIDTH = 32,      
    ADDR_WIDTH = 5,       
    DEPTH      = 32       
) (
    input  wire                  clk,       
    input  wire                  reset,     
    input  wire                  sclk_en,   
    output wire                  if_full_n, 
    input  wire                  if_write_ce, 
    input  wire                  if_write,  
    input  wire [DATA_WIDTH-1:0] if_din,    
    output wire                  if_empty_n, 
    input  wire                  if_read_ce, 
    input  wire                  if_read,   
    output wire [DATA_WIDTH-1:0] if_dout    
);
(* ram_style = MEM_STYLE *) 
reg  [DATA_WIDTH-1:0] mem[0:DEPTH-1]; 
reg  [DATA_WIDTH-1:0] q_buf = 1'b0;   
reg  [ADDR_WIDTH-1:0] waddr = 1'b0;   
reg  [ADDR_WIDTH-1:0] raddr = 1'b0;   
wire [ADDR_WIDTH-1:0] wnext;          
wire [ADDR_WIDTH-1:0] rnext;          
wire                  push;           
wire                  pop;            
reg  [ADDR_WIDTH-1:0] usedw = 1'b0;   
reg                   full_n = 1'b1;  
reg                   empty_n = 1'b0; 
reg  [DATA_WIDTH-1:0] q_tmp = 1'b0;   
reg                   show_ahead = 1'b0; 
reg  [DATA_WIDTH-1:0] dout_buf = 1'b0; 
reg                   dout_valid = 1'b0; 