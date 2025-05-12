module fir_lp_800kHz(
    aclk, 
    s_axis_data_tvalid, 
    s_axis_data_tready, 
    s_axis_data_tdata, 
    m_axis_data_tvalid, 
    m_axis_data_tdata 
)
;
  input aclk; 
  input s_axis_data_tvalid; 
  output s_axis_data_tready; 
  input [31:0] s_axis_data_tdata; 
  output m_axis_data_tvalid; 
  output [95:0] m_axis_data_tdata; 
endmodule