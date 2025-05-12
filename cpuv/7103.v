module ubbDemodulator #
  (
  parameter                              S_AXIS_CONFIG_TDATA_WIDTH = 32,
  parameter                              S_AXIS_RCVR_TDATA_WIDTH   = 16,
  parameter                              S_AXIS_RCVR_TUSER_WIDTH   = 2,
  parameter                              S_AXIS_NCO_TDATA_WIDTH    = 32,
  parameter                              S_AXIS_NCO_TUSER_WIDTH    = 2,
  parameter                              M_AXIS_TIME_TDATA_WIDTH   = 64,
  parameter                              M_AXIS_TIME_TUSER_WIDTH   = 2)
  (
  input                                  aclk,                 
  input                                  aresetn,              
  input  [S_AXIS_CONFIG_TDATA_WIDTH-1:0] s_axis_config_tdata,  
  input                                  s_axis_config_tvalid,
  output                                 s_axis_config_tready,
  input                                  s_axis_config_tlast,
  input  [S_AXIS_RCVR_TDATA_WIDTH-1:0]   s_axis_rcvr_tdata,    
  input  [S_AXIS_RCVR_TUSER_WIDTH-1:0]   s_axis_rcvr_tuser,
  input                                  s_axis_rcvr_tvalid,
  output                                 s_axis_rcvr_tready,
  input                                  s_axis_rcvr_tlast,
  input  [S_AXIS_NCO_TDATA_WIDTH-1:0]    s_axis_nco_tdata,     
  input  [S_AXIS_NCO_TUSER_WIDTH-1:0]    s_axis_nco_tuser,
  input                                  s_axis_nco_tvalid,
  output                                 s_axis_nco_tready,
  input                                  s_axis_nco_tlast,
  output [M_AXIS_TIME_TDATA_WIDTH-1:0]   m_axis_time_tdata,    
  output [M_AXIS_TIME_TUSER_WIDTH-1:0]   m_axis_time_tuser,
  output                                 m_axis_time_tvalid,
  input                                  m_axis_time_tready,
  output                                 m_axis_time_tlast
);
endmodule