module dds_compiler_0(
    aclk,                       
    s_axis_phase_tvalid,        
    s_axis_phase_tdata,         
    m_axis_data_tvalid,         
    m_axis_data_tdata           
);
input aclk;                        
input s_axis_phase_tvalid;         
input [23:0] s_axis_phase_tdata;   
output m_axis_data_tvalid;         
output [15:0] m_axis_data_tdata;   
endmodule 