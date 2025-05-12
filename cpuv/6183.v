module) 
wire [14:0] newslotcounter; 
wire [3:0] q_ctl; 
assign q_ctl = (rx_cmd == QUERY) ? rx_q : q_adj; 
reg [14:0] slotcountermask; 
always @ (q_ctl) begin 
  case(q_ctl) 
  endcase
end
assign newslotcounter = currentrn[14:0] & slotcountermask; 
always @ (posedge clk or posedge reset) begin 
  if (reset) begin 
  end else if (commstate == STATE_TX) begin 
  end else if (commstate == STATE_RX) begin  
  end
end
endmodule