module 
always@(posedge clk or negedge rst) begin
  if(rst == 1'b0)
    core_data_in <= IDLEDATA;
  else if(output_dval)
    core_data_in <= flash_q;
  else
    core_data_in <= IDLEDATA;
end 
always@(posedge clk or negedge rst) begin
  if(rst == 1'b0) begin
    c <= `countWidth'd0; 
    new_mode <= 1'b0; 
  end else begin
    if(ack_mode_read)
      new_mode <= 1'b1;
    else
      new_mode <= 1'b0;
    if(new_mode)
      c <= repeat_counter;
    else if(mode_done & (c > `countWidth'd0) )
      c <= c - 1'd1;
    else
      c <= c;
  end 
end 
endmodule 