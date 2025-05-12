
module axi_write_controller  #(parameter 
       TCQ               = 1,
       M_AXI_TDATA_WIDTH = 32,
       M_AXI_ADDR_WIDTH  = 32,
       M_AXI_IDWIDTH     = 5,
       BAR0AXI           = 64'h00000000,
       BAR1AXI           = 64'h00000000,
       BAR2AXI           = 64'h00000000,
       BAR3AXI           = 64'h00000000,
       BAR4AXI           = 64'h00000000,
       BAR5AXI           = 64'h00000000,
       BAR0SIZE          = 12,
       BAR1SIZE          = 12,
       BAR2SIZE          = 12,
       BAR3SIZE          = 12,
       BAR4SIZE          = 12,
       BAR5SIZE          = 12)
  (input  m_axi_aclk,
   input  m_axi_aresetn,
   output [(0-1)+M_AXI_ADDR_WIDTH:0] m_axi_awaddr,
   output [2:0] m_axi_awprot,
   output m_axi_awvalid,
   input  m_axi_awready,
   output [M_AXI_TDATA_WIDTH-1:0] m_axi_wdata,
   output [(M_AXI_TDATA_WIDTH/8)+(0-1):0] m_axi_wstrb,
   output m_axi_wvalid,
   input  m_axi_wready,
   input  [1:0] m_axi_bresp,
   input  m_axi_bvalid,
   output m_axi_bready,
   input  mem_req_valid,
   output mem_req_ready,
   input  [2:0] mem_req_bar_hit,
   input  [31:0] mem_req_pcie_address,
   input  [3:0] mem_req_byte_enable,
   input  mem_req_write_readn,
   input  mem_req_phys_func,
   input  [31:0] mem_req_write_data);

  localparam  IDLE = 4'b0001;
  localparam  WRITE_REQ = 4'b0010;
  localparam  WRITE_DATA = 4'b0100;
  reg  [3:0]  aximm_wr_sm = IDLE;
  reg  mem_req_ready_r;
  reg  m_axi_awvalid_r;
  reg  m_axi_wvalid_r;
  reg  [31:0] m_axi_addr_c;
  reg  [3:0] mem_req_byte_enable_r;
  reg  [2:0] mem_req_bar_hit_r;
  reg  [31:0] mem_req_pcie_address_r;
  reg  [31:0] mem_req_write_data_r;

  
  always @(posedge m_axi_aclk)
      if (!m_axi_aresetn) 
        begin
          aximm_wr_sm <= #TCQ IDLE;
          mem_req_ready_r <= #TCQ 1'b0;
          m_axi_awvalid_r <= #TCQ 1'b0;
          m_axi_wvalid_r <= #TCQ 1'b0;
        end
      else 
        case (aximm_wr_sm)

          IDLE: begin
                if (mem_req_write_readn & mem_req_valid) 
                  begin
                    aximm_wr_sm <= #TCQ WRITE_REQ;
                    m_axi_awvalid_r <= #TCQ 1'b1;
                    mem_req_ready_r <= #TCQ 1'b0;
                  end
                else 
                  begin
                    m_axi_awvalid_r <= #TCQ 1'b0;
                    mem_req_ready_r <= #TCQ 1'b1;
                  end
              end

          WRITE_REQ: begin
                if (m_axi_awready) 
                  begin
                    aximm_wr_sm <= #TCQ WRITE_DATA;
                    m_axi_awvalid_r <= #TCQ 1'b0;
                    m_axi_wvalid_r <= #TCQ 1'b1;
                  end
                  
              end

          WRITE_DATA: begin
                if (m_axi_wready) 
                  begin
                    aximm_wr_sm <= #TCQ IDLE;
                    m_axi_wvalid_r <= #TCQ 1'b0;
                    mem_req_ready_r <= #TCQ 1'b1;
                  end
                  
              end

          default: begin
                aximm_wr_sm <= #TCQ IDLE;
              end

        endcase

  assign mem_req_ready = mem_req_ready_r;
  assign m_axi_awaddr = m_axi_addr_c;
  assign m_axi_awprot = 0;
  assign m_axi_awvalid = m_axi_awvalid_r;
  assign m_axi_wdata = mem_req_write_data_r;
  assign m_axi_wstrb = mem_req_byte_enable_r;
  assign m_axi_wvalid = m_axi_wvalid_r;
  assign m_axi_bready = 1'b1;
  
  always @(posedge m_axi_aclk)
      begin
        if (mem_req_write_readn & (mem_req_valid & mem_req_ready)) 
          begin
            mem_req_byte_enable_r <= mem_req_byte_enable;
            mem_req_bar_hit_r <= mem_req_bar_hit;
            mem_req_pcie_address_r <= mem_req_pcie_address;
            mem_req_write_data_r <= mem_req_write_data;
          end
          
      end
  
  always @(mem_req_bar_hit_r or mem_req_pcie_address_r)
      case (mem_req_bar_hit_r)

        3'b000: m_axi_addr_c <= {BAR0AXI[(0-1)+M_AXI_ADDR_WIDTH:BAR0SIZE],mem_req_pcie_address_r[(0-1)+BAR0SIZE:2],2'b00};

        3'b001: m_axi_addr_c <= {BAR1AXI[(0-1)+M_AXI_ADDR_WIDTH:BAR1SIZE],mem_req_pcie_address_r[BAR1SIZE-1:2],2'b00};

        3'b010: m_axi_addr_c <= {BAR2AXI[(0-1)+M_AXI_ADDR_WIDTH:BAR2SIZE],mem_req_pcie_address_r[BAR2SIZE+(0-1):2],2'b00};

        3'b011: m_axi_addr_c <= {BAR3AXI[(0-1)+M_AXI_ADDR_WIDTH:BAR3SIZE],mem_req_pcie_address_r[BAR3SIZE-1:2],2'b00};

        3'b100: m_axi_addr_c <= {BAR4AXI[(0-1)+M_AXI_ADDR_WIDTH:BAR4SIZE],mem_req_pcie_address_r[BAR4SIZE-1:2],2'b00};

        3'b101: m_axi_addr_c <= {BAR5AXI[(0-1)+M_AXI_ADDR_WIDTH:BAR5SIZE],mem_req_pcie_address_r[BAR5SIZE+(0-1):2],2'b00};

        3'b110: m_axi_addr_c <= 32'd0;

        3'b111: m_axi_addr_c <= 32'd0;

      endcase

endmodule

