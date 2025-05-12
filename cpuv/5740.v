module to send CMD58
         STATE_CMD58_SEND: begin
            spi_cmd_send_index <= 6'd58; 
            spi_cmd_send_arg <= 32'h00000000; 
            spi_cmd_send_crc <= 7'b0000000; 
            spi_cmd_send_en <= 1; 
            state <= STATE_R3_R7_SEND; 
            next_state <= STATE_CMD58_RECV; 
         end
         STATE_CMD58_RECV: begin
            if (spi_r3_r7_recv_done) begin 
               if (8'b0 == spi_r3_r7_recv_out[39:32] && 
                   spi_r3_r7_recv_out[30]) begin 
                  state <= STATE_CALIB_WAIT; 
               end else begin
                  state <= STATE_ERROR; 
               end
            end
         end
         STATE_CALIB_WAIT: begin
            if (calib_done) begin 
               state <= STATE_0xFF_WAIT; 
               next_state <= STATE_CMD17_SEND; 
            end
         end
         STATE_CMD17_SEND: begin
            spi_cmd_send_index <= 6'd17; 
            spi_cmd_send_arg <= { 17'b0, program_index, block_addr }; 
            spi_cmd_send_crc <= 7'b0000000; 
            spi_cmd_send_en <= 1; 
            state <= STATE_R1_SEND; 
            next_state <= STATE_CMD17_RECV; 
         end
         STATE_CMD17_RECV: begin
            if (spi_r1_recv_done) begin 
               if (8'b0 == spi_r1_recv_out) begin 
                  spi_data_read_en <= 1; 
                  state <= STATE_DATA_RECV; 
               end else begin
                  state <= STATE_ERROR; 
               end
            end
         end
         STATE_DATA_RECV: begin
            if (spi_data_read_error) begin 
               state <= STATE_ERROR; 
            end else if (spi_data_read_done) begin 
               progress <= progress + 2; 
               if (127 == block_addr) begin 
                  state <= STATE_DONE; 
               end else begin
                  block_addr <= block_addr + 1; 
                  state <= STATE_0xFF_WAIT; 
                  next_state <= STATE_CMD17_SEND; 
               end
            end
         end
         STATE_DONE: begin
            sclk_reset <= 1; 
            sdcard_cs <= 1; 
            done <= 1; 
         end
         STATE_ERROR: begin
            sclk_reset <= 1; 
            sdcard_cs <= 1; 
            error <= 1; 
         end
      endcase
   end
endmodule