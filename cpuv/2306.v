module FETCH(
  input clk, 
  input f_enable, 
  input write_mode, 
  input [31:0] addr, 
  input [31:0] data_i, 
  input [1:0] thread, 
  output reg [31:0] data_o, 
  output reg ack, 
  input W_CLK, 
  input W_ACK, 
  input [31:0] W_DATA_I, 
  output reg [31:0] W_DATA_O, 
  output reg [31:0] W_ADDR, 
  output reg W_WRITE 
);
reg read_from_bus; 
reg [1:0] state; 
reg [1:0] w_state; 
reg w_buff; 
reg w_ack_local; 
wire [4:0] reg_select; 
reg [31:0] registers[0:32]; 
assign reg_select = {thread, addr[2:0]};
initial
begin
 state <= `STATE_INIT;
 w_state <= 2'b00;
 data_o <= 0;
 ack <= 0;
end
always @(posedge clk)
begin
  case (state)
    `STATE_INIT: 
      if (f_enable) 
      begin
        if (addr[31:28] == 4'hF) 
	  begin
	    if (write_mode) 
	      registers[reg_select] <= data_i; 
	    else 
	      data_o <= registers[reg_select]; 
	    ack <= 1; 
	  end
	  else 
	  begin
            read_from_bus <= 1; 
	    state <= `STATE_W_FETCH; 
	  end
       end
       else 
         ack <= 0; 
    `STATE_W_FETCH: 
       begin
         if (w_ack_local) 
         begin
          data_o <= w_buff; 
	  ack <= 1; 
          state <= `STATE_INIT; 
        end
       end
  endcase
end
always @(posedge W_CLK)
begin
  if (read_from_bus) 
   case (w_state)
     2'b00: 
       begin
	 W_ADDR <= addr; 
	 w_state <= 2'b01; 
	 W_DATA_O <= data_i; 
	 W_WRITE <= write_mode; 
      end
    2'b01: 
     if (W_ACK) 
       begin
         w_buff <= W_DATA_I; 
         w_ack_local <= 1; 
	 w_state <= 2'b10; 
       end
    2'b10: 
     begin
       w_ack_local <= 0; 
       w_state <= 2'b00; 
       W_ADDR <= 32'hz; 
     end
    default: 
     w_ack_local <= 0; 
   endcase
end
endmodule