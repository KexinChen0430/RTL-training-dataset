module sqrt(
    aclk,                           
    s_axis_cartesian_tvalid,        
    s_axis_cartesian_tdata,         
    m_axis_dout_tvalid,             
    m_axis_dout_tdata               
)
;
  input aclk;                       
  input s_axis_cartesian_tvalid;    
  input [15:0] s_axis_cartesian_tdata; 
  output m_axis_dout_tvalid;        
  output [15:0] m_axis_dout_tdata;  
endmodule