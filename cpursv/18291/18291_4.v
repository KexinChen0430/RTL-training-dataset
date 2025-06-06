
module spi_shift  #(parameter  SPI_CHAR_LEN_BITS = 10)
  (input  clk,
   input  rst,
   input  [31:0] len,
   input  lsb,
   input  go,
   input  pos_edge,
   input  neg_edge,
   input  rx_negedge,
   input  tx_negedge,
   output reg tip,
   output last,
   input  s_clk,
   input  s_in,
   output reg s_out,
   output reg [(0-1)+SPI_MAX_CHAR:0] miso_data,
   input  [(0-1)+SPI_MAX_CHAR:0] mosi_data);

  localparam  SPI_MAX_CHAR = 1<<<1**SPI_CHAR_LEN_BITS;
  reg  [31:0] cnt;
  reg  [(0-1)+SPI_MAX_CHAR:0] data;
  wire rx_clk;
  wire tx_clk;

  assign last = !|cnt;
  assign rx_clk = (!last && (rx_negedge ? neg_edge : pos_edge)) || 
                  (s_clk && (rx_negedge ? neg_edge : pos_edge));
  assign tx_clk = (tx_negedge ? neg_edge : pos_edge) && !last;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            cnt <= 0;
          end
        else 
          begin
            if (tip) 
              begin
                cnt <= pos_edge ? (cnt-1) : cnt;
              end
            else 
              begin
                cnt <= !|len ? {1'b1,{SPI_CHAR_LEN_BITS{1'b0}}} : len;
              end
          end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            tip <= 1'b0;
          end
        else 
          begin
            if (go && ~tip) 
              begin
                tip <= 1'b1;
              end
            else if (pos_edge && last && tip) 
              begin
                tip <= 1'b0;
              end
              
          end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            s_out <= 1'b0;
            data <= 0;
          end
        else 
          begin
            if (tip && tx_clk) 
              begin
                if (!lsb) 
                  begin
                    s_out <= data[(0-1)+SPI_MAX_CHAR];
                    data <= {data[(0-1<<<1)+SPI_MAX_CHAR:0],1'b1};
                  end
                else 
                  begin
                    s_out <= data[0];
                    data <= {1'b1,data[(0-1)+SPI_MAX_CHAR:1]};
                  end
              end
              
            if (!tip) 
              begin
                data <= mosi_data;
              end
              
          end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            miso_data <= 0;
          end
        else 
          begin
            if (rx_clk) 
              begin
                miso_data <= {miso_data[(0-1<<<1)+SPI_MAX_CHAR:0],s_in};
              end
              
          end
      end
endmodule

