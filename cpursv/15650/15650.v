
module axis_fifo_64  #(parameter 
       ADDR_WIDTH = 12,
       DATA_WIDTH = 64,
       KEEP_WIDTH = DATA_WIDTH/8)
  (input  wire clk,
   input  wire rst,
   input  wire [DATA_WIDTH-1:0] input_axis_tdata,
   input  wire [KEEP_WIDTH-1:0] input_axis_tkeep,
   input  wire input_axis_tvalid,
   output wire input_axis_tready,
   input  wire input_axis_tlast,
   input  wire input_axis_tuser,
   output wire [DATA_WIDTH-1:0] output_axis_tdata,
   output wire [KEEP_WIDTH-1:0] output_axis_tkeep,
   output wire output_axis_tvalid,
   input  wire output_axis_tready,
   output wire output_axis_tlast,
   output wire output_axis_tuser);

  reg  [ADDR_WIDTH:0]  wr_ptr = {ADDR_WIDTH+1{1'b0}};
  reg  [ADDR_WIDTH:0]  rd_ptr = {ADDR_WIDTH+1{1'b0}};
  reg  [((DATA_WIDTH+KEEP_WIDTH)+2)-1:0] 
       data_out_reg = {1'b0,1'b0,{KEEP_WIDTH{1'b0}},{DATA_WIDTH{1'b0}}};
  reg  [((DATA_WIDTH+KEEP_WIDTH)+2)-1:0] mem[(2**ADDR_WIDTH)-1:0];
  reg   output_read = 1'b0;
  reg   output_axis_tvalid_reg = 1'b0;
  wire [((DATA_WIDTH+KEEP_WIDTH)+2)-1:0] 
       data_in = {input_axis_tlast,input_axis_tuser,input_axis_tkeep,input_axis_tdata};
  wire 
       full = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) && 
(wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);
  wire  empty = wr_ptr == rd_ptr;
  wire  write = input_axis_tvalid & ~full;
  wire 
       read = (output_axis_tready | ~output_axis_tvalid_reg) & ~empty;

  assign {output_axis_tlast,output_axis_tuser,output_axis_tkeep,output_axis_tdata} = data_out_reg;
  assign input_axis_tready = ~full;
  assign output_axis_tvalid = output_axis_tvalid_reg;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            wr_ptr <= 0;
          end
        else if (write) 
          begin
            mem[wr_ptr[ADDR_WIDTH-1:0]] <= data_in;
            wr_ptr <= wr_ptr+1;
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

