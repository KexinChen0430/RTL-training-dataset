module BMD_CFG_CTRL (
    clk,
    rst_n,
    cfg_bus_mstr_enable,
    cfg_dwaddr,
    cfg_rd_en_n,
    cfg_do,
    cfg_rd_wr_done_n,
    cfg_cap_max_lnk_width,
    cfg_cap_max_lnk_speed,
    cfg_cap_max_payload_size
);
input               clk; 
input               rst_n; 
input               cfg_bus_mstr_enable; 
output [9:0]        cfg_dwaddr; 
output              cfg_rd_en_n; 
input  [31:0]       cfg_do; 
input               cfg_rd_wr_done_n; 
output [5:0]        cfg_cap_max_lnk_width; 
output [3:0]        cfg_cap_max_lnk_speed; 
output [2:0]        cfg_cap_max_payload_size; 
reg [4:0]           cfg_intf_state; 
reg                 cfg_bme_state; 
reg [9:0]           cfg_dwaddr; 
reg                 cfg_rd_en_n; 
reg [15:0]          cfg_msi_control; 
reg [5:0]           cfg_cap_max_lnk_width; 
reg [3:0]            cfg_cap_max_lnk_speed; 
reg [2:0]           cfg_cap_max_payload_size; 
always @(posedge clk ) begin
  if ( !rst_n ) begin
    cfg_dwaddr <= 0;
    cfg_rd_en_n <= 1'b1;
    cfg_msi_control <= 16'b0;
    cfg_cap_max_lnk_width <= 6'b0;
    cfg_cap_max_lnk_speed <= 4'b0;
    cfg_cap_max_payload_size <= 3'b0;
    cfg_intf_state <= `BMD_CFG_STATE_RESET; 
    cfg_bme_state <= cfg_bus_mstr_enable; 
  end else begin
    case ( cfg_intf_state )
      `BMD_CFG_STATE_RESET : begin
        cfg_bme_state <= cfg_bus_mstr_enable; 
        if (cfg_rd_wr_done_n == 1'b1 && cfg_bus_mstr_enable) begin
          cfg_dwaddr <= `BMD_CFG_MSI_CAP0_ADDR; 
          cfg_rd_en_n <= 1'b0; 
          cfg_intf_state <= `BMD_CFG_STATE_MSI; 
        end else begin
          cfg_intf_state <= `BMD_CFG_STATE_RESET;
          cfg_rd_en_n <= 1'b1;
        end
      end
      `BMD_CFG_STATE_MSI : begin
        if (cfg_rd_wr_done_n == 1'b0) begin
          cfg_msi_control <= cfg_do[31:16]; 
          cfg_dwaddr <= `BMD_CFG_DEV_CAP_ADDR; 
          cfg_rd_en_n <= 1'b0; 
          cfg_intf_state <= `BMD_CFG_STATE_DCAP; 
        end else begin
          cfg_intf_state <= `BMD_CFG_STATE_MSI;
        end
      end
      `BMD_CFG_STATE_DCAP : begin
        if (cfg_rd_wr_done_n == 1'b0) begin
          cfg_cap_max_payload_size <= cfg_do[2:0]; 
          cfg_dwaddr <= `BMD_CFG_LNK_CAP_ADDR; 
          cfg_rd_en_n <= 1'b0; 
          cfg_intf_state <= `BMD_CFG_STATE_LCAP; 
        end else begin
          cfg_intf_state <= `BMD_CFG_STATE_DCAP;
        end
      end
      `BMD_CFG_STATE_LCAP : begin
        if (cfg_rd_wr_done_n == 1'b0) begin
          cfg_cap_max_lnk_width <= cfg_do[9:4]; 
          cfg_cap_max_lnk_speed <= cfg_do[3:0]; 
          cfg_intf_state <= `BMD_CFG_STATE_END; 
        end else begin
          cfg_intf_state <= `BMD_CFG_STATE_LCAP;
        end
      end
      `BMD_CFG_STATE_END : begin
        cfg_dwaddr <= 0; 
        cfg_rd_en_n <= 1'b1; 
        if (cfg_bme_state != cfg_bus_mstr_enable)
          cfg_intf_state <= `BMD_CFG_STATE_RESET; 
        else
          cfg_intf_state <= `BMD_CFG_STATE_END; 
      end
    endcase
  end
end
endmodule