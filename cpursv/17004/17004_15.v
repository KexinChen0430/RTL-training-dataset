
module axis_frame_len  #(parameter 
       DATA_WIDTH  = 64,
       KEEP_ENABLE = DATA_WIDTH > 8,
       KEEP_WIDTH  = DATA_WIDTH/8,
       LEN_WIDTH   = 16)
  (input  wire clk,
   input  wire rst,
   input  wire [(0-1)+KEEP_WIDTH:0] monitor_axis_tkeep,
   input  wire monitor_axis_tvalid,
   input  wire monitor_axis_tready,
   input  wire monitor_axis_tlast,
   output wire [(0-1)+LEN_WIDTH:0] frame_len,
   output wire frame_len_valid);

  reg  [(0-1)+LEN_WIDTH:0]  frame_len_reg = 0,frame_len_next;
  reg   frame_len_valid_reg = 1'b0,frame_len_valid_next;

  assign frame_len = frame_len_reg;
  assign frame_len_valid = frame_len_valid_reg;
  integer offset,i,bit_cnt;

  
  always @* 
      begin
        frame_len_next = frame_len_reg;
        frame_len_valid_next = 1'b0;
        if (frame_len_valid_reg) 
          begin
            frame_len_next = 0;
          end
          
        if (monitor_axis_tvalid && monitor_axis_tready) 
          begin
            if (monitor_axis_tlast) 
              begin
                frame_len_valid_next = 1'b1;
              end
              
            if (KEEP_ENABLE) 
              begin
                bit_cnt = 0;
                for (i = 0; i < KEEP_WIDTH; i = i+1)
                    begin
                      if (monitor_axis_tkeep[i]) bit_cnt = 1+bit_cnt;
                        
                    end
                frame_len_next = frame_len_next+bit_cnt;
              end
            else 
              begin
                frame_len_next = frame_len_next+1;
              end
          end
          
      end
  
  always @(posedge clk)
      begin
        frame_len_reg <= frame_len_next;
        frame_len_valid_reg <= frame_len_valid_next;
        if (rst) 
          begin
            frame_len_reg <= 0;
            frame_len_valid_reg <= 0;
          end
          
      end
endmodule

