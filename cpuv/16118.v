module is_ready 
write_pixel_state: 
begin
  write_o <= 1'b0; 
  if(ack_i) 
    ack_o <= 1'b1; 
end
endcase 
end 
always @(posedge clk_i or posedge rst_i) 
if(rst_i) 
  state <= wait_state; 
else
  case (state) 
    wait_state: 
      if(write_i & ~discard_pixel) 
      begin
        if(zbuffer_enable_i) 
          state <= z_read_state; 
        else
          state <= write_pixel_state; 
      end
    z_read_state: 
      if(z_ack_i) 
        state <= fail_z_check ? wait_state : write_pixel_state; 
    write_pixel_state: 
      if(ack_i) 
        state <= wait_state; 
  endcase 
endmodule 