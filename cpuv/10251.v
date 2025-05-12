module sdio_fbr #( 
    parameter               INDEX           =   0, 
    parameter               FUNC_TYPE       =   4'h0, 
    parameter               FUNC_TYPE_EXT   =   4'h0, 
    parameter               SUPPORT_PWR_SEL =   1'b0, 
    parameter               CSA_SUPPORT     =   0, 
    parameter               CSA_OFFSET      =   0, 
    parameter               CIS_OFFSET      =   0, 
    parameter               BLOCK_SIZE      =   256 
)(
  input                     clk, 
  input                     rst, 
  output  reg               o_csa_en, 
  output  reg   [3:0]       o_pwr_mode, 
  output  reg   [15:0]      o_block_size, 
  input                     i_activate, 
  input                     i_write_flag, 
  input         [7:0]       i_address, 
  input                     i_data_stb, 
  input         [7:0]       i_data_in, 
  output  reg   [7:0]       o_data_out 
);
localparam     PARAM1  = 32'h00000000; 
wire            [7:0]       fbr [18:0]; 
wire            [23:0]      cis_addr; 
wire            [15:0]      vendor_id = `VENDOR_ID; 
wire            [15:0]      product_id  = `PRODUCT_ID; 
wire                        csa_support = CSA_SUPPORT; 
wire            [3:0]       func_type_ext = FUNC_TYPE_EXT; 
wire                        support_pwr_sel = SUPPORT_PWR_SEL; 
assign  cis_addr                        = CIS_OFFSET; 
assign  fbr[`FBR_FUNC_ID_ADDR]          = {o_csa_en, csa_support, 2'b00, FUNC_TYPE}; 
assign  fbr[`FBR_FUNC_EXT_ID_ADDR]      = {4'h0, func_type_ext}; 
assign  fbr[`FBR_POWER_SUPPLY_ADDR]     = {o_pwr_mode, 3'b000, support_pwr_sel}; 
assign  fbr[`FBR_ISDIO_FUNC_ID_ADDR]    = {8'h00}; 
assign  fbr[`FBR_MANF_ID_LOW_ADDR]      = {vendor_id[15:8]}; 
assign  fbr[`FBR_MANF_ID_HIGH_ADDR]     = {vendor_id[7:0]}; 
assign  fbr[`FBR_PROD_ID_LOW_ADDR]      = {product_id[15:8]}; 
assign  fbr[`FBR_PROD_ID_HIGH_ADDR]     = {product_id[7:0]}; 
assign  fbr[`FBR_ISDIO_PROD_TYPE]       = {8'h00}; 
assign  fbr[`FBR_CIS_LOW_ADDR]          = {cis_addr[23:16]}; 
assign  fbr[`FBR_CIS_MID_ADDR]          = {cis_addr[23:16]}; 
assign  fbr[`FBR_CIS_HIGH_ADDR]         = {cis_addr[23:16]}; 
assign  fbr[`FBR_CSA_LOW_ADDR]          = {8'h00}; 
assign  fbr[`FBR_CSA_MID_ADDR]          = {8'h00}; 
assign  fbr[`FBR_CSA_HIGH_ADDR]         = {8'h00}; 
assign  fbr[`FBR_DATA_ACC_ADDR]         = {8'h00}; 
assign  fbr[`FBR_BLOCK_SIZE_LOW_ADDR]   = {o_block_size[7:0]}; 
assign  fbr[`FBR_BLOCK_SIZE_HIGH_ADDR]  = {o_block_size[15:8]}; 
always @ (posedge clk) begin 
  if (rst) begin 
    o_pwr_mode              <=  0; 
    o_data_out              <=  0; 
    o_csa_en                <=  0; 
    o_block_size            <=  BLOCK_SIZE; 
  end
  else begin 
    if (i_activate) begin 
      if (i_data_stb) begin 
        if (i_write_flag) begin 
          case(i_address) 
            `FBR_FUNC_ID_ADDR: 
              o_csa_en            <=  i_data_in[3]; 
            `FBR_POWER_SUPPLY_ADDR: 
              o_pwr_mode          <=  i_data_in[7:5]; 
            `FBR_BLOCK_SIZE_LOW_ADDR: 
              o_block_size[7:0]   <=  i_data_in; 
            `FBR_BLOCK_SIZE_HIGH_ADDR: 
              o_block_size[15:8]  <=  i_data_in; 
            default: begin 
            end
          endcase 
        end
        else begin 
          o_data_out          <=  fbr[i_address]; 
        end
      end
    end
  end
end 
endmodule 