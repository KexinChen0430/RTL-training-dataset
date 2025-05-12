module axi_protocol_converter_v2_1_8_axilite_conv # 
  (
   parameter         C_FAMILY                    = "virtex6", 
   parameter integer C_AXI_ID_WIDTH              = 1, 
   parameter integer C_AXI_ADDR_WIDTH            = 32, 
   parameter integer C_AXI_DATA_WIDTH            = 32, 
   parameter integer C_AXI_SUPPORTS_WRITE        = 1, 
   parameter integer C_AXI_SUPPORTS_READ         = 1, 
   parameter integer C_AXI_RUSER_WIDTH           = 1, 
   parameter integer C_AXI_BUSER_WIDTH           = 1 
   )
  (
   input  wire                          ACLK, 
   input  wire                          ARESETN, 
  wire s_awvalid_i; 
  wire s_arvalid_i; 
  wire [C_AXI_ADDR_WIDTH-1:0] m_axaddr; 
endmodule