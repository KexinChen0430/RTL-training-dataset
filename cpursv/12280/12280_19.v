
module dmac_2d_transfer  #(parameter 
       DMA_AXI_ADDR_WIDTH        = 32,
       DMA_LENGTH_WIDTH          = 24,
       BYTES_PER_BURST_WIDTH     = 7,
       BYTES_PER_BEAT_WIDTH_SRC  = 3,
       BYTES_PER_BEAT_WIDTH_DEST = 3)
  (input  req_aclk,
   input  req_aresetn,
   input  req_valid,
   output reg req_ready,
   input  [DMA_AXI_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH_DEST] req_dest_address,
   input  [DMA_AXI_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH_SRC] req_src_address,
   input  [(-1)+DMA_LENGTH_WIDTH:0] req_x_length,
   input  [(-1)+DMA_LENGTH_WIDTH:0] req_y_length,
   input  [(-1)+DMA_LENGTH_WIDTH:0] req_dest_stride,
   input  [(-1)+DMA_LENGTH_WIDTH:0] req_src_stride,
   input  req_sync_transfer_start,
   input  req_last,
   output reg req_eot,
   output reg [BYTES_PER_BURST_WIDTH-1:0] req_measured_burst_length,
   output reg req_response_partial,
   output reg req_response_valid,
   input  req_response_ready,
   input  out_abort_req,
   output reg out_req_valid,
   input  out_req_ready,
   output [DMA_AXI_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH_DEST] out_req_dest_address,
   output [DMA_AXI_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH_SRC] out_req_src_address,
   output [(-1)+DMA_LENGTH_WIDTH:0] out_req_length,
   output reg out_req_sync_transfer_start,
   output out_req_last,
   input  out_eot,
   input  [BYTES_PER_BURST_WIDTH-1:0] out_measured_burst_length,
   input  out_response_partial,
   input  out_response_valid,
   output reg  out_response_ready = 1'b1);

  reg  [DMA_AXI_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH_DEST]  dest_address = 'h00;
  reg  [DMA_AXI_ADDR_WIDTH-1:BYTES_PER_BEAT_WIDTH_SRC]  src_address = 'h00;
  reg  [(-1)+DMA_LENGTH_WIDTH:0]  x_length = 'h00;
  reg  [(-1)+DMA_LENGTH_WIDTH:0]  y_length = 'h00;
  reg  [(-1)+DMA_LENGTH_WIDTH:0]  dest_stride = 'h0;
  reg  [(-1)+DMA_LENGTH_WIDTH:0]  src_stride = 'h00;
  reg   gen_last = 'h0;
  reg  [1:0]  req_id = 'h00;
  reg  [1:0]  eot_id = 'h00;
  reg  [3:0]  last_req = 'h00;
  wire out_last;

  assign out_req_dest_address = dest_address;
  assign out_req_src_address = src_address;
  assign out_req_length = x_length;
  assign out_last = y_length == 'h00;
  
  always @(posedge req_aclk)
      begin
        if (req_aresetn == 1'b0) 
          begin
            req_id <= 2'b0;
            eot_id <= 2'b0;
            req_eot <= 1'b0;
          end
        else 
          begin
            if ((out_req_valid == 1'b1) && (out_req_ready == 1'b1)) 
              begin
                req_id <= 1'b1+req_id;
              end
              
            if ((out_response_valid == 1'b1) && 
                (out_response_ready == 1'b1) && (out_eot == 1'b1)) 
              begin
                eot_id <= eot_id+1'b1;
                req_eot <= last_req[eot_id];
              end
            else 
              begin
                req_eot <= 1'b0;
              end
          end
      end
  
  always @(posedge req_aclk)
      begin
        if ((out_req_valid == 1'b1) && (out_req_ready == 1'b1)) 
          begin
            last_req[req_id] <= out_last;
          end
          
      end
  
  always @(posedge req_aclk)
      begin
        if ((out_response_valid == 1'b1) && 
            (out_response_ready == 1'b1)) 
          begin
            req_measured_burst_length <= out_measured_burst_length;
            req_response_partial <= out_response_partial;
          end
          
      end
  
  always @(posedge req_aclk)
      begin
        if ((out_response_valid == 1'b1) && 
            (out_response_ready == 1'b1)) 
          begin
            req_response_valid <= 1'b1;
          end
        else if (req_response_ready == 1'b1) 
          begin
            req_response_valid <= 1'b0;
          end
          
      end
  
  always @(posedge req_aclk)
      begin
        if (req_aresetn == 1'b0) 
          begin
            out_response_ready <= 1'b1;
          end
        else if (out_response_ready == 1'b1) 
          begin
            out_response_ready <= ~out_response_valid;
          end
        else if (req_response_ready == 1'b1) 
          begin
            out_response_ready <= 1'b1;
          end
          
      end
  
  always @(posedge req_aclk)
      begin
        if ((req_valid == 1'b1) && (req_ready == 1'b1)) 
          begin
            dest_address <= req_dest_address;
            src_address <= req_src_address;
            x_length <= req_x_length;
            y_length <= req_y_length;
            dest_stride <= req_dest_stride;
            src_stride <= req_src_stride;
            out_req_sync_transfer_start <= req_sync_transfer_start;
            gen_last <= req_last;
          end
        else if (out_abort_req == 1'b1) 
          begin
            y_length <= 0;
          end
        else if ((out_req_valid == 1'b1) && (out_req_ready == 1'b1)) 
          begin
            dest_address <= dest_address+dest_stride[(-1)+DMA_LENGTH_WIDTH:BYTES_PER_BEAT_WIDTH_DEST];
            src_address <= src_stride[(-1)+DMA_LENGTH_WIDTH:BYTES_PER_BEAT_WIDTH_SRC]+src_address;
            y_length <= y_length-1'b1;
            out_req_sync_transfer_start <= 1'b0;
          end
          
      end
  
  always @(posedge req_aclk)
      begin
        if (req_aresetn == 1'b0) 
          begin
            req_ready <= 1'b1;
            out_req_valid <= 1'b0;
          end
        else 
          begin
            if ((req_valid == 1'b1) && (req_ready == 1'b1)) 
              begin
                req_ready <= 1'b0;
                out_req_valid <= 1'b1;
              end
            else if ((out_req_ready == 1'b1) && 
                     ((out_last == 1'b1) && (out_req_valid == 1'b1))) 
              begin
                out_req_valid <= 1'b0;
                req_ready <= 1'b1;
              end
              
          end
      end
  assign out_req_last = gen_last & out_last;
endmodule

