
module axis_frame_fifo  #(parameter 
       ADDR_WIDTH     = 12,
       DATA_WIDTH     = 8,
       DROP_WHEN_FULL = 0)
  (input  wire clk,
   input  wire rst,
   input  wire [(0-1)+DATA_WIDTH:0] input_axis_tdata,
   input  wire input_axis_tvalid,
   output wire input_axis_tready,
   input  wire input_axis_tlast,
   input  wire input_axis_tuser,
   output wire [(0-1)+DATA_WIDTH:0] output_axis_tdata,
   output wire output_axis_tvalid,
   input  wire output_axis_tready,
   output wire output_axis_tlast);

  reg  [ADDR_WIDTH:0]  wr_ptr = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  wr_ptr_cur = {1+ADDR_WIDTH{1'b0}};
  reg  [ADDR_WIDTH:0]  rd_ptr = {1+ADDR_WIDTH{1'b0}};
  reg   drop_frame = 1'b0;
  reg  [(1+DATA_WIDTH)+(0-1):0]  data_out_reg = {1'b0,{DATA_WIDTH{1'b0}}};
  reg  [(1+DATA_WIDTH)+(0-1):0] mem[(1<<1**ADDR_WIDTH)+(0-1):0];
  reg   output_read = 1'b0;
  reg   output_axis_tvalid_reg = 1'b0;
  wire [(1+DATA_WIDTH)+(0-1):0]  data_in = {input_axis_tlast,input_axis_tdata};
  wire 
       full = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) && 
(wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);
  wire  empty = wr_ptr == rd_ptr;
  wire 
       full_cur = 
(wr_ptr[ADDR_WIDTH-1:0] == wr_ptr_cur[ADDR_WIDTH-1:0]) && (wr_ptr[ADDR_WIDTH] != wr_ptr_cur[ADDR_WIDTH]);
  wire 
       write = input_axis_tvalid & (DROP_WHEN_FULL | (~full & input_axis_tvalid));
  wire 
       read = ~empty & (((~output_axis_tvalid_reg & (output_axis_tready | ~empty)) & ~empty) | ((~empty & output_axis_tready) | ~output_axis_tvalid_reg));

  assign {output_axis_tlast,output_axis_tdata} = data_out_reg;
  assign input_axis_tready = ~full | DROP_WHEN_FULL;
  assign output_axis_tvalid = output_axis_tvalid_reg;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            wr_ptr <= 0;
            wr_ptr_cur <= 0;
            drop_frame <= 0;
          end
        else if (write) 
          begin
            if (full | (full_cur | drop_frame)) 
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
                mem[wr_ptr_cur[ADDR_WIDTH-1:0]] <= data_in;
                wr_ptr_cur <= wr_ptr_cur+1;
                if (input_axis_tlast) 
                  begin
                    if (input_axis_tuser) 
                      begin
                        wr_ptr_cur <= wr_ptr;
                      end
                    else 
                      begin
                        wr_ptr <= wr_ptr_cur+1;
                      end
                  end
                  
              end
          end
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            rd_ptr <= 0;
          end
        else if (read) 
          begin
            data_out_reg <= mem[rd_ptr[ADDR_WIDTH-1:0]];
            rd_ptr <= rd_ptr+1;
          end
          
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            output_axis_tvalid_reg <= 1'b0;
          end
        else if (output_axis_tready | ~output_axis_tvalid_reg) 
          begin
            output_axis_tvalid_reg <= ~empty;
          end
        else 
          begin
            output_axis_tvalid_reg <= output_axis_tvalid_reg;
          end
      end
endmodule

