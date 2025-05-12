module xfft(
  input aclk, 
  input [7:0] s_axis_config_tdata, 
  input s_axis_config_tvalid,      
  output s_axis_config_tready,     
  input [31:0] s_axis_data_tdata,  
  input s_axis_data_tvalid,        
  output s_axis_data_tready,       
  input s_axis_data_tlast,         
  output [63:0] m_axis_data_tdata, 
  output [15:0] m_axis_data_tuser, 
  output m_axis_data_tvalid,       
  input m_axis_data_tready,        
  output m_axis_data_tlast,        
  output event_frame_started,          
  output event_tlast_unexpected,       
  output event_tlast_missing,          
  output event_status_channel_halt,    
  output event_data_in_channel_halt,   
  output event_data_out_channel_halt   
);
endmodule 