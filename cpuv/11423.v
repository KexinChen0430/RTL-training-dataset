module is_busy_and
always@(posedge clk)
begin
  if(rst||mem_done_access)
    flits_reg<=175'h0000;
else if(v_d_flits_m)
    flits_reg<=d_flits_m;
end
always@(posedge clk)
begin
  if(rst||mem_done_access)
    d_m_cstate<=1'b0;
  else if(v_d_flits_m)
    d_m_cstate<=1'b1;
end
assign d_m_areg_flits=flits_reg;
endmodule