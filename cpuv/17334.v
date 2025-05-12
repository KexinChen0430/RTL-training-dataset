module dp_ram(
  s_aclk,            
  s_aresetn,         
  s_axis_tvalid,     
  s_axis_tready,     
  s_axis_tdata,      
  m_axis_tvalid,     
  m_axis_tready,     
  m_axis_tdata,      
  axis_data_count    
);
input s_aclk;                
input s_aresetn;             
input s_axis_tvalid;         
output s_axis_tready;        
input [7 : 0] s_axis_tdata;  
output m_axis_tvalid;        
input m_axis_tready;         
output [7 : 0] m_axis_tdata; 
output [11 : 0] axis_data_count; 
endmodule 