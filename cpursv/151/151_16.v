
module usdrx1_spi(spi_afe_csn,spi_clk_csn,spi_clk,spi_mosi,spi_miso,
                  spi_afe_sdio,spi_clk_sdio);

  input  [3:0] spi_afe_csn;
  input  spi_clk_csn;
  input  spi_clk;
  input  spi_mosi;
  output spi_miso;
  inout  spi_afe_sdio;
  inout  spi_clk_sdio;
  reg  [5:0]  spi_count = 'd0;
  reg   spi_rd_wr_n = 'd0;
  reg   spi_enable = 'd0;
  wire [1:0] spi_csn_3_s;
  wire spi_csn_s;
  wire spi_enable_s;
  wire spi_afe_miso_s;
  wire spi_clk_miso_s;

  assign spi_csn_3_s[1] = &spi_afe_csn;
  assign spi_csn_3_s[0] = spi_clk_csn;
  assign spi_csn_s = &spi_csn_3_s;
  assign spi_enable_s = ~spi_csn_s & spi_enable;
  
  always @(posedge spi_clk or posedge spi_csn_s)
      begin
        if (spi_csn_s == 1'b1) 
          begin
            spi_count <= 6'd0;
            spi_rd_wr_n <= 1'd0;
          end
        else 
          begin
            spi_count <= 1'b1+spi_count;
            if (spi_count == 6'd0) 
              begin
                spi_rd_wr_n <= spi_mosi;
              end
              
          end
      end
  
  always @(negedge spi_clk or posedge spi_csn_s)
      begin
        if (spi_csn_s == 1'b1) 
          begin
            spi_enable <= 1'b0;
          end
        else 
          begin
            if (
(((spi_count == 6'd16) && (spi_csn_3_s[1] == 1'b0)) || 
(spi_csn_3_s[0] == 1'b0)) && (spi_count == 6'd16)) 
              begin
                spi_enable <= spi_rd_wr_n;
              end
              
          end
      end
  assign spi_miso = (((~spi_csn_3_s[1] & spi_clk_miso_s) & (~spi_csn_3_s[0] | spi_afe_miso_s)) | (spi_clk_miso_s & ((spi_afe_miso_s & ~spi_csn_3_s[1]) | ~spi_csn_3_s[0]))) | (spi_afe_miso_s & ~spi_csn_3_s[1]);
  assign spi_afe_miso_s = spi_afe_sdio;
  assign spi_afe_sdio = (spi_enable_s == 1'b1) ? 1'bz : spi_mosi;
  assign spi_clk_miso_s = spi_clk_sdio;
  assign spi_clk_sdio = (spi_enable_s == 1'b1) ? 1'bz : spi_mosi;
endmodule

