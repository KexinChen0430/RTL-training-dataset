module transmitter(
  clock, trxClock, reset, disabledGroups,
  write, wrdata, id, xon, xoff,
  tx, busy);
parameter [31:0] FREQ = 100000000; 
parameter [31:0] BAUDRATE = 115200; 
parameter BITLENGTH = FREQ / BAUDRATE; 
input clock; 
input trxClock; 
input reset; 
input write; 
input [31:0] wrdata; 
input [3:0] disabledGroups; 
input id; 
input xon; 
input xoff; 
output tx; 
output busy; 
parameter TRUE = 1'b1; 
parameter FALSE = 1'b0; 
reg [31:0] sampled_wrdata, next_sampled_wrdata; 
reg [3:0] sampled_disabledGroups, next_sampled_disabledGroups; 
reg [3:0] bits, next_bits; 
reg [2:0] bytesel, next_bytesel; 
reg paused, next_paused; 
reg byteDone, next_byteDone; 
reg busy, next_busy; 
reg [9:0] txBuffer, next_txBuffer; 
assign tx = txBuffer[0]; 
reg [9:0] counter, next_counter; 
wire counter_zero = ~|counter; 
reg writeByte; 
reg [7:0] byte; 
reg disabled; 
always #1
begin
  byte = 0; 
  disabled = 0; 
  case (bytesel[1:0]) 
    2'h0 : begin byte = sampled_wrdata[7:0]; disabled = sampled_disabledGroups[0]; end 
    2'h1 : begin byte = sampled_wrdata[15:8]; disabled = sampled_disabledGroups[1]; end 
    2'h2 : begin byte = sampled_wrdata[23:16]; disabled = sampled_disabledGroups[2]; end 
    2'h3 : begin byte = sampled_wrdata[31:24]; disabled = sampled_disabledGroups[3]; end 
  endcase
end
always @ (posedge clock)
begin
  counter = next_counter; 
  bits = next_bits; 
  byteDone = next_byteDone; 
  txBuffer = next_txBuffer; 
end
always #1
begin
  next_bits = bits; 
  next_byteDone = byteDone; 
  next_txBuffer = txBuffer; 
  next_counter = counter; 
  if (writeByte)
    begin
      next_counter = BITLENGTH; 
      next_bits = 0; 
      next_byteDone = FALSE; 
      next_txBuffer = {1'b1,byte,1'b0}; 
    end
  else if (counter_zero)
    begin
      next_counter = BITLENGTH; 
      next_txBuffer = {1'b1,txBuffer[9:1]}; 
      if (bits == 4'hA)
        next_byteDone = TRUE; 
      else next_bits = bits + 1'b1; 
    end
  else if (trxClock)
    next_counter = counter + 1'b1; 
end
parameter [1:0] IDLE = 0, SEND = 1, POLL = 2; 
reg [1:0] state, next_state; 
always @ (posedge clock or posedge reset)
begin
  if (reset)
    begin
      state = IDLE; 
      sampled_wrdata = 32'h0; 
      sampled_disabledGroups = 4'h0; 
      bytesel = 3'h0; 
      busy = FALSE; 
      paused = FALSE; 
    end
  else
    begin
      state = next_state; 
      sampled_wrdata = next_sampled_wrdata; 
      sampled_disabledGroups = next_sampled_disabledGroups; 
      bytesel = next_bytesel; 
      busy = next_busy; 
      paused = next_paused; 
    end
end
always #1
begin
  next_state = state; 
  next_sampled_wrdata = sampled_wrdata; 
  next_sampled_disabledGroups = sampled_disabledGroups; 
  next_bytesel = bytesel; 
  next_busy = (state != IDLE) || write || paused; 
  next_paused = xoff | (paused & !xon); 
  writeByte = FALSE; 
  case(state) 
    IDLE :
      begin
        next_sampled_wrdata = wrdata; 
        next_sampled_disabledGroups = disabledGroups; 
        next_bytesel = 2'h0; 
        if (write)
          next_state = SEND; 
        else if (id)  
	  begin
            next_sampled_wrdata = 32'h534c4131; 
            next_sampled_disabledGroups = 4'b0000;
            next_state = SEND;
          end
      end
    SEND :
      begin
        writeByte = TRUE; 
	next_bytesel = bytesel+1'b1; 
        next_state = POLL; 
      end
    POLL :
      begin
	if (byteDone && !paused)
          next_state = (bytesel[2]) ? IDLE : SEND; 
      end
  endcase
end
endmodule