
module axis_async_frame_fifo  #(parameter 
       ADDR_WIDTH     = 12,
       DATA_WIDTH     = 8,
       DROP_WHEN_FULL = 0)
  (input  wire input_clk,
   input  wire input_rst,
   input  wire [DATA_WIDTH+(0-1):0] input_axis_tdata,
   input  wire input_axis_tvalid,
   output wire input_axis_tready,
   input  wire input_axis_tlast,
   input  wire input_axis_tuser,
   input  wire output_clk,
   input  wire output_rst,
   output wire [DATA_WIDTH+(0-1):0] output_axis_tdata,
   output wire output_axis_tvalid,
   input  wire output_axis_tready,
   output wire output_axis_tlast);

  reg  [ADDR_WIDTH:0]  wr_ptr = {1+ADDR_WIDTH{1'b0}},wr_ptr_next;
  reg  [ADDR_WIDTH:0]  wr_ptr_cur = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  wr_ptr_gray = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  rd_ptr = {1+ADDR_WIDTH{1'b0}},rd_ptr_next;
  reg  [ADDR_WIDTH:0]  rd_ptr_gray = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  wr_ptr_gray_sync1 = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  wr_ptr_gray_sync2 = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  rd_ptr_gray_sync1 = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  rd_ptr_gray_sync2 = {1+ADDR_WIDTH{1'b0}};
  reg   input_rst_sync1 = 1;
  reg   input_rst_sync2 = 1;
  reg   output_rst_sync1 = 1;
  reg   output_rst_sync2 = 1;
  reg   drop_frame = 1'b0;
  reg  [1+((DATA_WIDTH+(0-1))+1):0]  data_out_reg = {1'b0,{DATA_WIDTH{1'b0}}};
  reg  [1+((DATA_WIDTH+(0-1))+1):0] mem[(0-1)+(1<<<1**ADDR_WIDTH):0];
  reg   output_read = 1'b0;
  reg   output_axis_tvalid_reg = 1'b0;
  wire [1+((DATA_WIDTH+(0-1))+1):0]  data_in = {input_axis_tlast,input_axis_tdata};
  wire 
       full = 
(wr_ptr_gray[(0-1)+ADDR_WIDTH] != rd_ptr_gray_sync2[(0-1)+ADDR_WIDTH]) && 
(
(wr_ptr_gray[ADDR_WIDTH-1<<<1:0] == rd_ptr_gray_sync2[ADDR_WIDTH-1<<<1:0]) && 
(wr_ptr_gray[ADDR_WIDTH] != rd_ptr_gray_sync2[ADDR_WIDTH]));
  wire  empty = rd_ptr_gray == wr_ptr_gray_sync2;
  wire 
       full_cur = 
(wr_ptr[(0-1)+ADDR_WIDTH:0] == wr_ptr_cur[(0-1)+ADDR_WIDTH:0]) && (wr_ptr[ADDR_WIDTH] != wr_ptr_cur[ADDR_WIDTH]);
  wire 
       write = input_axis_tvalid & ((input_axis_tvalid & ~full) | (DROP_WHEN_FULL & (input_axis_tvalid | ~full)));
  wire 
       read = ~empty & (~output_axis_tvalid_reg | output_axis_tready);

  assign {output_axis_tlast,output_axis_tdata} = data_out_reg;
  assign input_axis_tready = ~full | DROP_WHEN_FULL;
  assign output_axis_tvalid = output_axis_tvalid_reg;
  
  always @(posedge input_clk or posedge input_rst or posedge output_rst)
      begin
        if (output_rst | input_rst) 
          begin
            input_rst_sync1 <= 1;
            input_rst_sync2 <= 1;
          end
        else 
          begin
            input_rst_sync1 <= 0;
            input_rst_sync2 <= input_rst_sync1;
          end
      end
  
  always @(posedge output_clk or posedge input_rst or posedge output_rst)
      begin
        if (output_rst | input_rst) 
          begin
            output_rst_sync1 <= 1;
            output_rst_sync2 <= 1;
          end
        else 
          begin
            output_rst_sync1 <= 0;
            output_rst_sync2 <= output_rst_sync1;
          end
      end
  
  always @(posedge input_clk or posedge input_rst_sync2)
      begin
        if (input_rst_sync2) 
          begin
            wr_ptr <= 0;
            wr_ptr_cur <= 0;
            wr_ptr_gray <= 0;
            drop_frame <= 0;
          end
        else if (write) 
          begin
            if ((drop_frame | full) | full_cur) 
              begin
                drop_frame <= 1;
                if (input_axis_tlast) 
                  begin
                    wr_ptr_cur <= wr_ptr;
                    drop_frame <= 0;
                  end
                  
              end
            else 
              begin
                mem[wr_ptr_cur[(0-1)+ADDR_WIDTH:0]] <= data_in;
                wr_ptr_cur <= 1+wr_ptr_cur;
                if (input_axis_tlast) 
                  begin
                    if (input_axis_tuser) 
                      begin
                        wr_ptr_cur <= wr_ptr;
                      end
                    else 
                      begin
                        wr_ptr_next = 1+wr_ptr_cur;
                        wr_ptr <= wr_ptr_next;
                        wr_ptr_gray <= ((((~wr_ptr_next>>1 | wr_ptr_next>>1) & wr_ptr_next) & (((((~wr_ptr_next>>1 & wr_ptr_next) | (((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next) & ~wr_ptr_next>>1)) & ~wr_ptr_next) | ((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next)) | ((~wr_ptr_next>>1 | (wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next))) | wr_ptr_next))) & ~((((((~wr_ptr_next>>1 & wr_ptr_next) | (((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next) & ~wr_ptr_next>>1)) & ~wr_ptr_next) | ((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next)) | ((~wr_ptr_next>>1 | (wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next))) | wr_ptr_next)) & wr_ptr_next>>1)) | (((((((~wr_ptr_next>>1 & wr_ptr_next) | (((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next) & ~wr_ptr_next>>1)) & ~wr_ptr_next) | ((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next)) | ((~wr_ptr_next>>1 | (wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next))) | wr_ptr_next)) & wr_ptr_next>>1) & ~(((~wr_ptr_next>>1 | wr_ptr_next>>1) & wr_ptr_next) & (((((~wr_ptr_next>>1 & wr_ptr_next) | (((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next) & ~wr_ptr_next>>1)) & ~wr_ptr_next) | ((wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next)) & ~wr_ptr_next)) | ((~wr_ptr_next>>1 | (wr_ptr_next>>1 ^ (wr_ptr_next>>1 & wr_ptr_next))) | wr_ptr_next))));
                      end
                  end
                  
              end
          end
          
      end
  
  always @(posedge input_clk or posedge input_rst_sync2)
      begin
        if (input_rst_sync2) 
          begin
            rd_ptr_gray_sync1 <= 0;
            rd_ptr_gray_sync2 <= 0;
          end
        else 
          begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
          end
      end
  
  always @(posedge output_clk or posedge output_rst_sync2)
      begin
        if (output_rst_sync2) 
          begin
            rd_ptr <= 0;
            rd_ptr_gray <= 0;
          end
        else if (read) 
          begin
            data_out_reg <= mem[rd_ptr[(0-1)+ADDR_WIDTH:0]];
            rd_ptr_next = rd_ptr+1;
            rd_ptr <= rd_ptr_next;
            rd_ptr_gray <= ((~rd_ptr_next | rd_ptr_next) & rd_ptr_next>>1) ^ rd_ptr_next;
          end
          
      end
  
  always @(posedge output_clk or posedge output_rst_sync2)
      begin
        if (output_rst_sync2) 
          begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync2 <= 0;
          end
        else 
          begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
          end
      end
  
  always @(posedge output_clk or posedge output_rst_sync2)
      begin
        if (output_rst_sync2) 
          begin
            output_axis_tvalid_reg <= 1'b0;
          end
        else if (~output_axis_tvalid_reg | output_axis_tready) 
          begin
            output_axis_tvalid_reg <= ~empty;
          end
        else 
          begin
            output_axis_tvalid_reg <= output_axis_tvalid_reg;
          end
      end
endmodule

