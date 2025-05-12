module is_busy_and
always@(posedge clk)
begin
  if(rst||mem_done_access)
    flits_reg<=48'h0000;
else if(v_i_flits_m)
    flits_reg<=i_flits_m;
end
always@(posedge clk)
begin
  if(rst||mem_done_access)
    i_m_cstate<=1'b0;
  else if(v_i_flits_m)
    i_m_cstate<=1'b1;
end
assign v_i_areg_m_flits=i_m_cstate;
assign i_m_areg_flits=flits_reg;
endmodule