module fifo_generator_v13_1_4_axic_reg_slice # 
(
   parameter C_FAMILY     = "virtex7", 
   parameter C_DATA_WIDTH = 32, 
   parameter C_REG_CONFIG = 32'h00000000 
)
(
   input  wire                      ACLK, 
   input  wire                      ARESET, 
   input  wire [C_DATA_WIDTH-1:0]   S_PAYLOAD_DATA, 
   input  wire                      S_VALID, 
   output wire                      S_READY, 
   output wire [C_DATA_WIDTH-1:0]   M_PAYLOAD_DATA, 
   output wire                      M_VALID, 
   input  wire                      M_READY 
);