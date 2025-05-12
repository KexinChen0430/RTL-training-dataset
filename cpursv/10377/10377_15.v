
module hls_contrast_stretch_AXILiteS_s_axi  #(parameter  C_S_AXI_ADDR_WIDTH = 6, C_S_AXI_DATA_WIDTH = 32)
  (input  wire ACLK,
   input  wire ARESET,
   input  wire ACLK_EN,
   input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
   input  wire AWVALID,
   output wire AWREADY,
   input  wire [C_S_AXI_DATA_WIDTH+(-1):0] WDATA,
   input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] WSTRB,
   input  wire WVALID,
   output wire WREADY,
   output wire [1:0] BRESP,
   output wire BVALID,
   input  wire BREADY,
   input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
   input  wire ARVALID,
   output wire ARREADY,
   output wire [C_S_AXI_DATA_WIDTH+(-1):0] RDATA,
   output wire [1:0] RRESP,
   output wire RVALID,
   input  wire RREADY,
   output wire [15:0] height,
   output wire [15:0] width,
   output wire [7:0] min,
   output wire [7:0] max);

  localparam 
       ADDR_HEIGHT_DATA_0 = 6'h10,
       ADDR_HEIGHT_CTRL   = 6'h14,
       ADDR_WIDTH_DATA_0  = 6'h18,
       ADDR_WIDTH_CTRL    = 6'h1c,
       ADDR_MIN_DATA_0    = 6'h20,
       ADDR_MIN_CTRL      = 6'h24,
       ADDR_MAX_DATA_0    = 6'h28,
       ADDR_MAX_CTRL      = 6'h2c,
       WRIDLE             = 2'd0,
       WRDATA             = 2'd1,
       WRRESP             = 2'd2,
       WRRESET            = 2'd3,
       RDIDLE             = 2'd0,
       RDDATA             = 2'd1,
       RDRESET            = 2'd2,
       ADDR_BITS          = 6;
  reg  [1:0]  wstate = WRRESET;
  reg  [1:0] wnext;
  reg  [(-1)+ADDR_BITS:0] waddr;
  wire [31:0] wmask;
  wire aw_hs;
  wire w_hs;
  reg  [1:0]  rstate = RDRESET;
  reg  [1:0] rnext;
  reg  [31:0] rdata;
  wire ar_hs;
  wire [(-1)+ADDR_BITS:0] raddr;
  reg  [15:0]  int_height = 'b0;
  reg  [15:0]  int_width = 'b0;
  reg  [7:0]  int_min = 'b0;
  reg  [7:0]  int_max = 'b0;

  assign AWREADY = wstate == WRIDLE;
  assign WREADY = wstate == WRDATA;
  assign BRESP = 2'b00;
  assign BVALID = wstate == WRRESP;
  assign wmask = {{8{WSTRB[3]}},{8{WSTRB[2]}},{8{WSTRB[1]}},{8{WSTRB[0]}}};
  assign aw_hs = AWREADY & AWVALID;
  assign w_hs = WREADY & WVALID;
  
  always @(posedge ACLK)
      begin
        if (ARESET) wstate <= WRRESET;
        else if (ACLK_EN) wstate <= wnext;
          
      end
  
  always @(*)
      begin
        case (wstate)

          WRIDLE: if (AWVALID) wnext = WRDATA;
              else wnext = WRIDLE;

          WRDATA: if (WVALID) wnext = WRRESP;
              else wnext = WRDATA;

          WRRESP: if (BREADY) wnext = WRIDLE;
              else wnext = WRRESP;

          default: wnext = WRIDLE;

        endcase

      end
  
  always @(posedge ACLK)
      begin
        if (ACLK_EN) 
          begin
            if (aw_hs) waddr <= AWADDR[(-1)+ADDR_BITS:0];
              
          end
          
      end
  assign ARREADY = rstate == RDIDLE;
  assign RDATA = rdata;
  assign RRESP = 2'b00;
  assign RVALID = rstate == RDDATA;
  assign ar_hs = ARREADY & ARVALID;
  assign raddr = ARADDR[(-1)+ADDR_BITS:0];
  
  always @(posedge ACLK)
      begin
        if (ARESET) rstate <= RDRESET;
        else if (ACLK_EN) rstate <= rnext;
          
      end
  
  always @(*)
      begin
        case (rstate)

          RDIDLE: if (ARVALID) rnext = RDDATA;
              else rnext = RDIDLE;

          RDDATA: if (RVALID & RREADY) rnext = RDIDLE;
              else rnext = RDDATA;

          default: rnext = RDIDLE;

        endcase

      end
  
  always @(posedge ACLK)
      begin
        if (ACLK_EN) 
          begin
            if (ar_hs) 
              begin
                rdata <= 1'b0;
                case (raddr)

                  ADDR_HEIGHT_DATA_0: begin
                        rdata <= int_height[15:0];
                      end

                  ADDR_WIDTH_DATA_0: begin
                        rdata <= int_width[15:0];
                      end

                  ADDR_MIN_DATA_0: begin
                        rdata <= int_min[7:0];
                      end

                  ADDR_MAX_DATA_0: begin
                        rdata <= int_max[7:0];
                      end

                endcase

              end
              
          end
          
      end
  assign height = int_height;
  assign width = int_width;
  assign min = int_min;
  assign max = int_max;
  
  always @(posedge ACLK)
      begin
        if (ARESET) int_height[15:0] <= 0;
        else if (ACLK_EN) 
          begin
            if ((waddr == ADDR_HEIGHT_DATA_0) && w_hs) 
              int_height[15:0] <= (int_height[15:0] | (WDATA[31:0] & wmask)) & ((int_height[15:0] | WDATA[31:0]) & (~wmask | WDATA[31:0]));
              
          end
          
      end
  
  always @(posedge ACLK)
      begin
        if (ARESET) int_width[15:0] <= 0;
        else if (ACLK_EN) 
          begin
            if ((waddr == ADDR_WIDTH_DATA_0) && w_hs) 
              int_width[15:0] <= ((WDATA[31:0] & wmask) | (WDATA[31:0] & ((((~wmask & (int_width[15:0] | WDATA[31:0])) | (WDATA[31:0] & wmask)) & int_width[15:0]) & ~wmask))) | ((int_width[15:0] | (WDATA[31:0] & wmask)) & ~wmask);
              
          end
          
      end
  
  always @(posedge ACLK)
      begin
        if (ARESET) int_min[7:0] <= 0;
        else if (ACLK_EN) 
          begin
            if ((waddr == ADDR_MIN_DATA_0) && w_hs) 
              int_min[7:0] <= (~wmask & int_min[7:0]) | (WDATA[31:0] & wmask);
              
          end
          
      end
  
  always @(posedge ACLK)
      begin
        if (ARESET) int_max[7:0] <= 0;
        else if (ACLK_EN) 
          begin
            if (w_hs && (waddr == ADDR_MAX_DATA_0)) 
              int_max[7:0] <= (int_max[7:0] & (~wmask & ((~wmask & (((((WDATA[31:0] & wmask) | (WDATA[31:0] & ((((~wmask & (int_width[15:0] | WDATA[31:0])) | (WDATA[31:0] & wmask)) & int_width[15:0]) & ~wmask))) | int_max[7:0]) & (int_max[7:0] | wmask)) | WDATA[31:0])) | (WDATA[31:0] & wmask)))) | ((~wmask | WDATA[31:0]) & ((WDATA[31:0] & wmask) | (int_max[7:0] & wmask)));
              
          end
          
      end
endmodule

