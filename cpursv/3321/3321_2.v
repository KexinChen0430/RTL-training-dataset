
module altera_up_video_dma_control_slave(clk,reset,address,byteenable,read,write,writedata,
                                         swap_addresses_enable,readdata,current_start_address,
                                         dma_enabled);

  parameter  DEFAULT_BUFFER_ADDRESS = 32'h00000000;
  parameter  DEFAULT_BACK_BUF_ADDRESS = 32'h00000000;
  parameter  WIDTH = 640;
  parameter  HEIGHT = 480;
  parameter  ADDRESSING_BITS = 16'h0809;
  parameter  COLOR_BITS = 4'h7;
  parameter  COLOR_PLANES = 2'h2;
  parameter  ADDRESSING_MODE = 1'b1;
  parameter  DEFAULT_DMA_ENABLED = 1'b1;
  input  clk;
  input  reset;
  input  [1:0] address;
  input  [3:0] byteenable;
  input  read;
  input  write;
  input  [31:0] writedata;
  input  swap_addresses_enable;
  output reg [31:0] readdata;
  output [31:0] current_start_address;
  output reg dma_enabled;
  reg  [31:0] buffer_start_address;
  reg  [31:0] back_buf_start_address;
  reg  buffer_swap;

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            readdata <= 32'h00000000;
          end
        else if (read & (address == 2'h0)) 
          begin
            readdata <= buffer_start_address;
          end
        else if ((address == 2'h1) & read) 
          begin
            readdata <= back_buf_start_address;
          end
        else if ((address == 2'h2) & read) 
          begin
            readdata[31:16] <= HEIGHT;
            readdata[15:0] <= WIDTH;
          end
        else if (read) 
          begin
            readdata[31:16] <= ADDRESSING_BITS;
            readdata[15:12] <= 4'h0;
            readdata[11:8] <= COLOR_BITS;
            readdata[7:6] <= COLOR_PLANES;
            readdata[5:3] <= 3'h0;
            readdata[2] <= dma_enabled;
            readdata[1] <= ADDRESSING_MODE;
            readdata[0] <= buffer_swap;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            buffer_start_address <= DEFAULT_BUFFER_ADDRESS;
            back_buf_start_address <= DEFAULT_BACK_BUF_ADDRESS;
          end
        else if (write & (address == 2'h1)) 
          begin
            if (byteenable[0]) back_buf_start_address[7:0] <= writedata[7:0];
              
            if (byteenable[1]) back_buf_start_address[15:8] <= writedata[15:8];
              
            if (byteenable[2]) back_buf_start_address[23:16] <= writedata[23:16];
              
            if (byteenable[3]) back_buf_start_address[31:24] <= writedata[31:24];
              
          end
        else if (buffer_swap & swap_addresses_enable) 
          begin
            buffer_start_address <= back_buf_start_address;
            back_buf_start_address <= buffer_start_address;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            buffer_swap <= 1'b0;
          end
        else if (write & (address == 2'h0)) 
          begin
            buffer_swap <= 1'b1;
          end
        else if (swap_addresses_enable) 
          begin
            buffer_swap <= 1'b0;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            dma_enabled <= DEFAULT_DMA_ENABLED;
          end
        else if (((address == 2'h3) & byteenable[0]) & write) 
          begin
            dma_enabled <= writedata[2];
          end
          
      end
  assign current_start_address = buffer_start_address;
endmodule

