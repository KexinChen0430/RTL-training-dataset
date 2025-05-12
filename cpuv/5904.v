module is_busy_and
always@(posedge clk)
begin
  if(rst||dc_done_access)
    flits_reg<=144'h0000;
  else if(v_m_flits_d)
    flits_reg<=m_flits_d;
end
always@(posedge clk)
begin
  if(rst||dc_done_access)
    m_d_cstate<=1'b0;
  else if(v_m_flits_d)
    m_d_cstate<=1'b1;
end
assign m_d_areg_flits=flits_reg;
endmodule