module cpx_spc_buf (
   cpx_spc_data_cx2_buf, cpx_spc_data_rdy_cx2_buf,
   cpx_spc_data_cx2, cpx_spc_data_rdy_cx2
   );
input  [`CPX_WIDTH-1:0] cpx_spc_data_cx2;
input                   cpx_spc_data_rdy_cx2;
output [`CPX_WIDTH-1:0] cpx_spc_data_cx2_buf;
output                  cpx_spc_data_rdy_cx2_buf;
assign  cpx_spc_data_rdy_cx2_buf  =  cpx_spc_data_rdy_cx2 ;
assign  cpx_spc_data_cx2_buf  =  cpx_spc_data_cx2 ;
endmodule