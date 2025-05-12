
module spi_slave(clk,reset,spiclk,spimosi,spimiso,spicsl,we,re,wdat,addr,rdat);

  parameter  asz = 7;
  parameter  dsz = 32;
  input  clk;
  input  reset;
  input  spiclk;
  input  spimosi;
  output spimiso;
  input  spicsl;
  output we;
  output re;
  output [dsz-1:0] wdat;
  output [(0-1)+asz:0] addr;
  input  [dsz-1:0] rdat;
  reg  [5:0] mosi_cnt;
  reg  [dsz-1:0] mosi_shift;
  reg  rd;
  reg  [(0-1)+asz:0] addr;
  reg  eoa;
  reg  re;
  reg  [dsz-1:0] wdat;
  reg  eot;
  wire  spi_reset = spicsl | reset;

  
  always @(posedge spiclk or posedge spi_reset)
      if (spi_reset) 
        begin
          mosi_cnt <= 'b0;
          mosi_shift <= 32'h0;
          eoa <= 'b0;
          rd <= 'b0;
          eot <= 'b0;
        end
      else 
        begin
          mosi_cnt <= 1+mosi_cnt;
          mosi_shift <= {mosi_shift[dsz+(-(1+1)):0],spimosi};
          if (mosi_cnt == 0) rd <= spimosi;
            
          if (mosi_cnt == asz) 
            begin
              addr <= {mosi_shift[asz+(-(1+1)):0],spimosi};
              eoa <= 1'b1;
            end
            
          re <= (mosi_cnt == asz) & rd;
          if (mosi_cnt == (dsz+asz)) 
            begin
              wdat <= {mosi_shift[dsz+(-(1+1)):0],spimosi};
              eot <= 1'b1;
            end
            
        end
  reg  [dsz-1:0] miso_shift;

  
  always @(negedge spiclk or posedge spi_reset)
      if (spi_reset) 
        begin
          miso_shift <= 32'h0;
        end
      else 
        begin
          if (re) miso_shift <= rdat;
          else miso_shift <= {miso_shift[dsz+(-(1+1)):0],1'b0};
        end
  assign spimiso = eoa ? miso_shift[dsz-1] : 1'b0;
  reg  [1+1:0] we_dly;

  reg  we;

  
  always @(posedge clk)
      if (reset) 
        begin
          we_dly <= 0;
          we <= 0;
        end
      else 
        begin
          we_dly <= {we_dly[1:0],eot};
          we <= ~rd & (we_dly[1] & ~we_dly[1+1]);
        end
endmodule

