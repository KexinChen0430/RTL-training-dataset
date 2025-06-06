
module usb_fifo_sync  #(parameter  ADDR_WIDTH = 4, WDATA_WIDTH = 0, RDATA_WIDTH = 0)
  (input  clk,
   input  rst0_async,
   input  rst0_sync,
   input  wr_en,
   input  [(-1)+(1<<<1**WDATA_WIDTH):0] wr_data,
   input  rd_en,
   output [(-1)+1<<<RDATA_WIDTH:0] rd_data,
   output fifo_full,
   output fifo_empty);

  localparam  FIFO_LENGTH = 1<<<1**ADDR_WIDTH;
  reg  [FIFO_LENGTH-1:0] mem;
  reg  [ADDR_WIDTH:WDATA_WIDTH] wr_addr;
  reg  [ADDR_WIDTH:RDATA_WIDTH] rd_addr;

  
  generate
      genvar k;
      for (k = 0; k < 1<<<RDATA_WIDTH; k = 1+k)
          begin : loopk
            assign rd_data[k] = mem[k+(rd_addr[ADDR_WIDTH-1:RDATA_WIDTH]*1<<<RDATA_WIDTH)];
          end
      if (WDATA_WIDTH > RDATA_WIDTH) 
        begin
          assign fifo_full = ((wr_addr[ADDR_WIDTH] != (rd_addr[ADDR_WIDTH] & wr_addr[ADDR_WIDTH-1:WDATA_WIDTH])) == rd_addr[ADDR_WIDTH-1:WDATA_WIDTH]) ? 1'b1 : 1'b0;
          assign fifo_empty = (wr_addr[ADDR_WIDTH:WDATA_WIDTH] == rd_addr[ADDR_WIDTH:WDATA_WIDTH]) ? 1'b1 : 1'b0;
        end
      else 
        begin
          assign fifo_full = ((wr_addr[ADDR_WIDTH] != (rd_addr[ADDR_WIDTH] & wr_addr[ADDR_WIDTH-1:RDATA_WIDTH])) == rd_addr[ADDR_WIDTH-1:RDATA_WIDTH]) ? 1'b1 : 1'b0;
          assign fifo_empty = (wr_addr[ADDR_WIDTH:RDATA_WIDTH] == rd_addr[ADDR_WIDTH:RDATA_WIDTH]) ? 1'b1 : 1'b0;
        end
  endgenerate

  
  always @(posedge clk or negedge rst0_async)
      begin
        if (!rst0_async) 
          begin
            wr_addr <= {ADDR_WIDTH+((-WDATA_WIDTH)+1){1'b0}};
            rd_addr <= {(0-RDATA_WIDTH)+(1+ADDR_WIDTH){1'b0}};
          end
        else 
          begin
            if (!rst0_sync) 
              begin
                wr_addr <= {ADDR_WIDTH+((-WDATA_WIDTH)+1){1'b0}};
                rd_addr <= {(0-RDATA_WIDTH)+(1+ADDR_WIDTH){1'b0}};
              end
            else 
              begin
                wr_addr <= (!fifo_full & wr_en) ? (wr_addr+1'b1) : wr_addr;
                rd_addr <= (rd_en & !fifo_empty) ? (1'b1+rd_addr) : rd_addr;
              end
          end
      end
  
  generate
      genvar i,j;
      for (i = 0; i < FIFO_LENGTH>>WDATA_WIDTH; i = 1+i)
          begin : loopi
            for (j = i<<WDATA_WIDTH; j < ((1<<<1**WDATA_WIDTH)*(1+i)); j = j+1)
                begin : loopj
                  
                  always @(posedge clk or negedge rst0_async)
                      if (!rst0_async) mem[j] <= 1'b0;
                      else 
                        mem[j] <= (wr_addr[ADDR_WIDTH-1:WDATA_WIDTH] == (wr_en & (i & !fifo_full))) ? wr_data[j%(1<<<1**WDATA_WIDTH)] : mem[j];
                end
          end
  endgenerate

endmodule

