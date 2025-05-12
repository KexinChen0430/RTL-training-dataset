module (assign)
  assign ULED = {heartbeat[24], 1'b0, 1'b0, 4'b0, error};
  reg [24:0] heartbeat;
  always @(posedge CLK) heartbeat <= heartbeat + 1;
  reg [511:0] dram_wdata;
  assign d_din = dram_wdata;
  always @(posedge CLK) begin
    if      (RST) dram_wdata <= 0; 
    else if (d_w) dram_wdata <= {480'h0, (dram_wdata[31:0]+32'h1)}; 
  end
  reg [511:0] dram_rdata;
  always @(posedge CLK) begin
    if      (RST)      dram_rdata <= 0; 
    else if (d_douten) dram_rdata <= {480'h0, (dram_rdata[31:0]+32'h1)}; 
  end
  reg error;
  always @(posedge CLK) begin
    if (RST) begin 
      state     <= WRITE;
      w_cnt     <= 0;
      r_cnt     <= 0;
      w_cycle   <= 0;
      r_cycle   <= 0;
      send_cnt  <= 0;
      lcd_data  <= 0;
      lcd_we    <= 0;
      d_req     <= 0;
      d_initadr <= 0;
      d_blocks  <= 0;
    end else begin
      case (state)
        WRITE: begin 
          if (d_req != 0) begin
            d_req   <= 0;
            w_cycle <= w_cycle + 1;
          end else if (!d_busy) begin
            if (w_cnt == `WRITE_ACCESS_CNT) begin
              state <= READ;
            end else begin
              d_req     <= `DRAM_REQ_WRITE;
              d_blocks  <= `DRAM_WBLOCKS;  
              d_initadr <= {3'b0,rand_addr[28:3],3'b0};
              w_cnt     <= w_cnt + 1;
              w_cycle   <= w_cycle + 1;
            end
          end else begin
            w_cycle <= w_cycle + 1;
          end
        end
        READ: begin 
          if (d_req != 0) begin
            d_req   <= 0;
            r_cycle <= r_cycle + 1;
          end else if (!d_busy) begin
            if (r_cnt == `READ_ACCESS_CNT) begin
              state <= RESULT;
            end else begin
              d_req     <= `DRAM_REQ_READ;
              d_blocks  <= `DRAM_RBLOCKS;  
              d_initadr <= {3'b0,rand_addr[28:3],3'b0};
              r_cnt     <= r_cnt + 1;
              r_cycle   <= r_cycle + 1;
            end
          end else begin
            r_cycle <= r_cycle + 1;
          end
        end
        RESULT: begin 
          if (!lcd_we && rdy && send_cnt < 2) begin
            lcd_we   <= 1;
            lcd_data <= (send_cnt == 0) ? w_cycle : r_cycle;
            send_cnt <= send_cnt + 1;
          end else begin
            lcd_we <= 0;
          end
        end
      endcase
    end
  end
endmodule