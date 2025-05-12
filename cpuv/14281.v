module (assign)
  assign ULED = {heartbeat[24], 1'b1, initdone, 4'b0, sortdone};
  reg [24:0] heartbeat;
  always @(posedge CLK) heartbeat <= heartbeat + 1;
  always @(posedge CLK) begin
    if (RST || !initdone) begin
      pcnt      <= 0;       
      pcnt_halt <= 0;       
    end else if (!pcnt_halt) begin
      if (!d_busy && sortdone) pcnt_halt <= 1; 
      else                     pcnt      <= pcnt + 1; 
    end
  end
  always @(posedge CLK) begin
    if (RST) begin
      pcnt_lcdwe <= 0;      
      pcnt_send  <= 0;      
    end else begin
      pcnt_lcdwe <= (!pcnt_lcdwe && rdy && (lcd_cnt >= `SHOWNUM) && !pcnt_send);
      if (pcnt_lcdwe) pcnt_send <= 1; 
    end
  end
  always @(posedge CLK) begin
    case ({lcd_we, (sfifo_scnt == 0)})
      2'b10: sfifo_dot_t <= {32'b0, sfifo_dot_t[`APPDATA_WIDTH-1:32]}; 
      2'b11: sfifo_dot_t <= sfifo_dot[`APPDATA_WIDTH-1:32]; 
    endcase
  end
  always @(posedge CLK) begin
    if (RST) begin
      sfifo_scnt <= 0;      
      lcd_cnt    <= 0;      
    end else begin
      if (lcd_we) begin
        sfifo_scnt <= sfifo_scnt + 1; 
        lcd_cnt    <= lcd_cnt + 1;    
      end
    end
  end
  always @(posedge CLK) sfifo_req   <= (sfifo_cnt<`VR_REQ_THRE); 
  always @(posedge CLK) sfifo_emp_r <= sfifo_emp; 
  always @(posedge CLK) begin
    if (RST) begin
      state      <= WAIT;             
      v_raddr    <= (last_phase[0]) ? 0 : (`SORT_ELM>>1); 
      v_cnt      <= 0;                
      v_c        <= 0;                
      v_dreq     <= 0;                
      v_dblocks  <= 0;                
      v_dinitadr <= 0;                
    end else begin
      case (state)
        WAIT: begin  
          if (pcnt_halt) state <= READJUDGE; 
        end
        READJUDGE: begin
          if (!d_busy) begin
            if (sfifo_req && !v_c) state <= READREQ; 
          end
        end
        READREQ: begin
          if (v_dreq != 0) begin
            v_dreq <= 0;             
            state  <= READING;       
          end else if (!d_busy) begin
            v_dreq     <= `DRAM_REQ_READ; 
            v_dblocks  <= `DRAM_VBLOCKS;  
            v_dinitadr <= v_raddr;        
            v_raddr    <= v_raddr + (`D_VS); 
            v_cnt      <= v_cnt + 1;        
            v_c        <= (v_cnt >= ((`SORT_ELM>>4)/`DRAM_VBLOCKS)-1); 
          end
        end
        READING: begin
          if (!d_busy) state <= READJUDGE; 
        end
      endcase
    end
  end
endmodule