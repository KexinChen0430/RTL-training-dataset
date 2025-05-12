module SPIMemory(_select, sck, mosi, miso, addr, data_out, data_in, rd, wr);
  input _select; 
  input sck;     
  input mosi;    
  output miso;   
  output [`SPI_MEM_ADDR_WIDTH-1:0] addr; 
  input [`SPI_MEM_DATA_WIDTH-1:0] data_in; 
  output [`SPI_MEM_DATA_WIDTH-1:0] data_out; 
  output rd; 
  output wr; 
  reg [`BYTE_COUNTER_WIDTH-1:0] spi_counter; 
  reg [`BYTE_WIDTH-1:0] spi_data; 
  reg [`BYTE_WIDTH-1:0] spi_addr_0; 
  reg [`BYTE_WIDTH-1:0] spi_addr_1; 
  always @ (posedge sck)
    if (~_select) 
      spi_data <= {spi_data[`BYTE_WIDTH-2:0], mosi}; 
  assign rd = (spi_counter == 0) & (spi_state == `SPI_MEM_STATE_DATA_READ);
  assign wr = (spi_counter == `BYTE_WIDTH-1) &
              (spi_state == `SPI_MEM_STATE_DATA_WRITE);
  assign addr = {spi_addr_1, spi_addr_0};
  assign data_out = spi_data;
  reg [`SPI_MEM_DATA_WIDTH-1:0] read_data;
  always @ (posedge sck)
    if (spi_counter == 0)
      read_data <= data_in;
  assign miso = (spi_counter == 0) ? data_in[`BYTE_WIDTH - 1]
                                   : read_data[`BYTE_WIDTH - 1 - spi_counter];
  reg [`SPI_MEM_STATE_WIDTH-1:0] spi_state; 
  reg [`SPI_MEM_STATE_WIDTH-1:0] spi_prev_state; 
  reg write_op;
  always @ (posedge _select or negedge sck) begin
    if (_select) begin 
      spi_state <= `SPI_MEM_STATE_ADDR_H;
      spi_prev_state <= `SPI_MEM_STATE_ADDR_H;
      spi_counter <= 1'b0;
      write_op <= 0;
    end else begin 
      if (spi_counter == `BYTE_WIDTH - 1) begin 
        case (spi_state) 
        `SPI_MEM_STATE_ADDR_H: 
          begin
            spi_state <= `SPI_MEM_STATE_ADDR_L; 
            spi_addr_1 <= {1'b0, spi_data[`BYTE_WIDTH-2:0]}; 
            write_op <= spi_data[`BYTE_WIDTH-1]; 
          end
        `SPI_MEM_STATE_ADDR_L: 
          begin
            spi_state <= write_op ? `SPI_MEM_STATE_DATA_WRITE 
                                  : `SPI_MEM_STATE_DATA_READ; 
            spi_addr_0 <= spi_data; 
          end
        `SPI_MEM_STATE_DATA_READ: 
          begin
            spi_addr_0 <= spi_addr_0 + 1'b1;
            if (spi_addr_0 == {`BYTE_WIDTH{1'b1}}) 
              spi_addr_1 <= (spi_addr_1 + 1'b1) & {(`BYTE_WIDTH-1){1'b1}}; 
          end
        endcase
        spi_prev_state <= spi_state; 
      end else if (spi_counter == 0 & spi_state == `SPI_MEM_STATE_DATA_WRITE &
                   spi_prev_state == spi_state) begin
        spi_addr_0 <= spi_addr_0 + 1'b1;
        if (spi_addr_0 == {`BYTE_WIDTH{1'b1}})
          spi_addr_1 <= (spi_addr_1 + 1'b1) & {(`BYTE_WIDTH-1){1'b1}};
      end
      spi_counter <= spi_counter + 1'b1; 
    end
  end
endmodule