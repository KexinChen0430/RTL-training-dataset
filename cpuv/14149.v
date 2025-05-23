module spc_pcx_buf (
   spc_pcx_data_pa,        
   spc_pcx_atom_pq,        
   spc_pcx_req_pq,         
   pcx_spc_grant_px_buf,   
   spc_pcx_data_pa_buf,    
   spc_pcx_atom_pq_buf,    
   spc_pcx_req_pq_buf,     
   pcx_spc_grant_px        
   );
input  [`PCX_WIDTH-1:0] spc_pcx_data_pa_buf; 
input                   spc_pcx_atom_pq_buf; 
input  [4:0]            spc_pcx_req_pq_buf;  
input  [4:0]            pcx_spc_grant_px;    
output [`PCX_WIDTH-1:0] spc_pcx_data_pa;     
output                  spc_pcx_atom_pq;     
output [4:0]            spc_pcx_req_pq;      
output [4:0]            pcx_spc_grant_px_buf;
assign  spc_pcx_req_pq  =  spc_pcx_req_pq_buf ; 
assign  spc_pcx_atom_pq  =  spc_pcx_atom_pq_buf ; 
assign  spc_pcx_data_pa  =  spc_pcx_data_pa_buf ; 
assign  pcx_spc_grant_px_buf  =  pcx_spc_grant_px ; 
endmodule