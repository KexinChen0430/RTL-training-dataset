
module image_processing_module(input  clk,
                               input  rst_n,
                               input  in_enable,
                               input  [(-1)+color_width:0] in_data,
                               output out_ready,
                               output [(-1)+color_width:0] out_data,
                               output [addr_width+(-1):0] ram_addr);

  parameter  wr_mode = 0;
  parameter  color_width = 8;
  parameter  im_width = 320;
  parameter  im_height = 240;
  parameter  addr_width = 17;
  parameter  ram_read_latency = 1+1;
  parameter  row_init = 0;
  reg  [addr_width+(-1):0] reg_ram_addr;
  reg  [3:0] con_ready;

  assign ram_addr = reg_ram_addr;
  assign out_data = out_ready ? in_data : 0;
  
  generate
      if (wr_mode == 0) 
        begin
          
          always @(posedge clk or negedge rst_n or negedge in_enable)
              begin
                if (~in_enable || ~rst_n) reg_ram_addr <= row_init*im_width;
                else if (reg_ram_addr == ((-1)+(im_height*im_width))) reg_ram_addr <= 0;
                else reg_ram_addr <= 1+reg_ram_addr;
              end
          assign out_ready = (~in_enable || ~rst_n) ? 0 : 1;
        end
      else 
        begin
          
          always @(posedge clk or negedge rst_n or negedge in_enable)
              begin
                if (~in_enable || ~rst_n) reg_ram_addr <= 0;
                else if (reg_ram_addr == ((-1)+(im_height*im_width))) reg_ram_addr <= 0;
                else reg_ram_addr <= 1+reg_ram_addr;
              end
          
          always @(posedge clk or negedge rst_n or negedge in_enable)
              begin
                if (~in_enable || ~rst_n) con_ready <= 0;
                else if (con_ready == ram_read_latency) con_ready <= con_ready;
                else con_ready <= 1+con_ready;
              end
          assign out_ready = (con_ready == ram_read_latency) ? 1 : 0;
        end
  endgenerate

endmodule

