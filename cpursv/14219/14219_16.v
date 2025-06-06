
module dmac_2d_transfer(input  req_aclk,
                        input  req_aresetn,
                        input  req_valid,
                        output reg req_ready,
                        input  [31:C_BYTES_PER_BEAT_WIDTH_DEST] req_dest_address,
                        input  [31:C_BYTES_PER_BEAT_WIDTH_SRC] req_src_address,
                        input  [C_DMA_LENGTH_WIDTH+(-1):0] req_x_length,
                        input  [C_DMA_LENGTH_WIDTH+(-1):0] req_y_length,
                        input  [C_DMA_LENGTH_WIDTH+(-1):0] req_dest_stride,
                        input  [C_DMA_LENGTH_WIDTH+(-1):0] req_src_stride,
                        input  req_sync_transfer_start,
                        output reg req_eot,
                        output reg out_req_valid,
                        input  out_req_ready,
                        output [31:C_BYTES_PER_BEAT_WIDTH_DEST] out_req_dest_address,
                        output [31:C_BYTES_PER_BEAT_WIDTH_SRC] out_req_src_address,
                        output [C_DMA_LENGTH_WIDTH+(-1):0] out_req_length,
                        output reg out_req_sync_transfer_start,
                        input  out_eot);

  parameter  C_DMA_LENGTH_WIDTH = 24;
  parameter  C_BYTES_PER_BEAT_WIDTH_SRC = 3;
  parameter  C_BYTES_PER_BEAT_WIDTH_DEST = 3;
  reg  [31:C_BYTES_PER_BEAT_WIDTH_DEST] dest_address;
  reg  [31:C_BYTES_PER_BEAT_WIDTH_SRC] src_address;
  reg  [C_DMA_LENGTH_WIDTH+(-1):0] x_length;
  reg  [C_DMA_LENGTH_WIDTH+(-1):0] y_length;
  reg  [C_DMA_LENGTH_WIDTH+(-1):0] dest_stride;
  reg  [C_DMA_LENGTH_WIDTH+(-1):0] src_stride;
  reg  [1:0] req_id;
  reg  [1:0] eot_id;
  reg  [3:0] last_req;

  assign out_req_dest_address = dest_address;
  assign out_req_src_address = src_address;
  assign out_req_length = x_length;
  
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
            if (out_req_valid && out_req_ready) 
              begin
                req_id <= req_id+1'b1;
                last_req[req_id] <= y_length == 0;
              end
              
            req_eot <= 1'b0;
            if (out_eot) 
              begin
                eot_id <= 1'b1+eot_id;
                req_eot <= last_req[eot_id];
              end
              
          end
      end
  
  always @(posedge req_aclk)
      begin
        if (req_aresetn == 1'b0) 
          begin
            dest_address <= 'h00;
            src_address <= 'h00;
            x_length <= 'h00;
            y_length <= 'h00;
            dest_stride <= 'h00;
            src_stride <= 'h00;
            req_ready <= 1'b1;
            out_req_valid <= 1'b0;
            out_req_sync_transfer_start <= 1'b0;
          end
        else 
          begin
            if (req_ready) 
              begin
                if (req_valid) 
                  begin
                    dest_address <= req_dest_address;
                    src_address <= req_src_address;
                    x_length <= req_x_length;
                    y_length <= req_y_length;
                    dest_stride <= req_dest_stride;
                    src_stride <= req_src_stride;
                    out_req_sync_transfer_start <= req_sync_transfer_start;
                    req_ready <= 1'b0;
                    out_req_valid <= 1'b1;
                  end
                  
              end
            else 
              begin
                if (out_req_valid && out_req_ready) 
                  begin
                    dest_address <= dest_address+dest_stride[C_DMA_LENGTH_WIDTH+(-1):C_BYTES_PER_BEAT_WIDTH_DEST];
                    src_address <= src_address+src_stride[C_DMA_LENGTH_WIDTH+(-1):C_BYTES_PER_BEAT_WIDTH_SRC];
                    y_length <= y_length-1'b1;
                    out_req_sync_transfer_start <= 1'b0;
                    if (y_length == 0) 
                      begin
                        out_req_valid <= 1'b0;
                        req_ready <= 1'b1;
                      end
                      
                  end
                  
              end
          end
      end
endmodule

