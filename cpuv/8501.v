module ccx_spc_rpt (
   spc_pcx_req_pq_buf, spc_pcx_atom_pq_buf, spc_pcx_data_pa_buf,
   pcx_spc_grant_px_buf, cpx_spc_data_cx2_buf,
   cpx_spc_data_rdy_cx2_buf,
   spc_pcx_req_pq, spc_pcx_atom_pq, spc_pcx_data_pa,
   pcx_spc_grant_px, cpx_spc_data_cx2, cpx_spc_data_rdy_cx2
   );
input  [4:0]            spc_pcx_req_pq;
input                   spc_pcx_atom_pq;
input  [`PCX_WIDTH-1:0] spc_pcx_data_pa;
input  [4:0]            pcx_spc_grant_px;
input  [`CPX_WIDTH-1:0] cpx_spc_data_cx2;
input                   cpx_spc_data_rdy_cx2;
output [4:0]            spc_pcx_req_pq_buf;
output                  spc_pcx_atom_pq_buf;
output [`PCX_WIDTH-1:0] spc_pcx_data_pa_buf;
output  [4:0]            pcx_spc_grant_px_buf;
output [`CPX_WIDTH-1:0] cpx_spc_data_cx2_buf;
output                  cpx_spc_data_rdy_cx2_buf;
assign  spc_pcx_req_pq_buf  =  spc_pcx_req_pq;
assign  spc_pcx_atom_pq_buf  =  spc_pcx_atom_pq;
assign  spc_pcx_data_pa_buf   =  spc_pcx_data_pa;
assign  pcx_spc_grant_px_buf  =  pcx_spc_grant_px;
assign  cpx_spc_data_cx2_buf  =  cpx_spc_data_cx2;
assign  cpx_spc_data_rdy_cx2_buf  =  cpx_spc_data_rdy_cx2;
endmodule