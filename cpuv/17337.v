module is 
next_srdy = 1'b1; 
end else begin 
next_state = WAIT_LOCK; 
end
end 
WAIT_SEN: begin 
if (SADDR == 2'b00)
next_rom_addr = 8'h00; 
else if(SADDR == 2'b01)
next_rom_addr = STATE_COUNT_CONST; 
else if(SADDR == 2'b10)
next_rom_addr = 2*STATE_COUNT_CONST; 
else
next_rom_addr = 3*STATE_COUNT_CONST; 
if (SEN) begin 
next_state = ADDRESS; 
end else begin
next_state = WAIT_SEN; 
end
end
ADDRESS: begin 
next_rst_mmcm = 1'b1; 
next_den = 1'b1; 
next_daddr = rom_do[38:32]; 
next_state = WAIT_A_DRDY; 
end
WAIT_A_DRDY: begin 
if (DRDY) begin 
next_state = BITMASK; 
end else begin
next_state = WAIT_A_DRDY; 
end
end
BITMASK: begin 
next_di = rom_do[31:16] & DO; 
next_state = BITSET; 
end
BITSET: begin 
next_di = rom_do[15:0] | DI; 
next_rom_addr = rom_addr + 1'b1; 
next_state = WRITE; 
end
WRITE: begin 
next_dwe = 1'b1; 
next_den = 1'b1; 
next_state_count = state_count - 1'b1; 
next_state = WAIT_DRDY; 
end
WAIT_DRDY: begin 
if(DRDY) begin 
if(state_count > 0) begin 
next_state = ADDRESS; 
end else begin
next_state = WAIT_LOCK; 
end
end else begin
next_state = WAIT_DRDY; 
end
end
default: begin 
next_state = RESTART; 
end
endcase
end
endmodule 