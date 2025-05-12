module is
   next_srdy   = 1'b1;
end else begin
   next_state  = WAIT_LOCK;
end
WAIT_SEN: begin
   if(SEN) begin
      case (SADDR)
           3'd0 : next_rom_addr = STATE_COUNT_CONST * 0;
           3'd1 : next_rom_addr = STATE_COUNT_CONST * 1;
           3'd2 : next_rom_addr = STATE_COUNT_CONST * 2;
           3'd3 : next_rom_addr = STATE_COUNT_CONST * 3;
           3'd4 : next_rom_addr = STATE_COUNT_CONST * 4;
           3'd5 : next_rom_addr = STATE_COUNT_CONST * 5;
           3'd6 : next_rom_addr = STATE_COUNT_CONST * 6;
           3'd7 : next_rom_addr = STATE_COUNT_CONST * 7;
           default : next_rom_addr = STATE_COUNT_CONST * 0;
      endcase
      next_state = ADDRESS;
   end else begin
      next_state = WAIT_SEN;
   end
end
ADDRESS: begin
   next_rst_pll  = 1'b1;
   next_den       = 1'b1;
   next_daddr     = rom_do[36:32];
   next_state     = WAIT_A_DRDY;
end
WAIT_A_DRDY: begin
   if(DRDY) begin
      next_state = BITMASK;
   end else begin
      next_state = WAIT_A_DRDY;
   end
end
BITMASK: begin
   next_di     = rom_do[31:16] & DO;
   next_state  = BITSET;
end
BITSET: begin
   next_di           = rom_do[15:0] | DI;
   next_rom_addr     = rom_addr + 1'b1;
   next_state        = WRITE;
end
WRITE: begin
   next_dwe          = 1'b1;
   next_den          = 1'b1;
   next_state_count  = state_count - 1'b1;
   next_state        = WAIT_DRDY;
end
WAIT_DRDY: begin
   if(DRDY) begin
      if(state_count > 0) begin
         next_state  = ADDRESS;
      end else begin
         next_state  = WAIT_LOCK;
      end
   end else begin
      next_state     = WAIT_DRDY;
   end
end
default: begin
   next_state = RESTART;
end
endcase
end
endmodule