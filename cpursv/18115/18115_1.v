
module dds(aclk,s_axis_phase_tvalid,s_axis_phase_tdata,
           m_axis_data_tvalid,m_axis_data_tdata);

  input  aclk;
  input  s_axis_phase_tvalid;
  input  [15:0] s_axis_phase_tdata;
  output m_axis_data_tvalid;
  output [31:0] m_axis_data_tdata;


endmodule

