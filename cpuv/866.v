module iobdg_int_mondo_addr_dec (
   creg_mdata0_dec,    
   creg_mdata1_dec,    
   creg_mbusy_dec,     
   mondo_data_addr,    
   addr_invld,         
   addr_in,            
   thr_id_in           
);
input [`IOB_ADDR_WIDTH-1:0]         addr_in;             
input [`IOB_CPUTHR_INDEX-1:0]       thr_id_in;           
output                              creg_mdata0_dec;     
output                              creg_mdata1_dec;     
output                              creg_mbusy_dec;      
output [`IOB_MONDO_DATA_INDEX-1:0]  mondo_data_addr;     
output                              addr_invld;          
wire                                creg_mdata0_alias_dec;
wire                                creg_mdata1_alias_dec;
wire                                creg_mbusy_alias_dec;
wire                                creg_mdata0_proper_dec;
wire                                creg_mdata1_proper_dec;
wire                                creg_mbusy_proper_dec;
wire                                use_thr_addr;        
assign creg_mdata0_alias_dec =
   (addr_in[`IOB_LOCAL_ADDR_WIDTH-1:0] == `IOB_CREG_MDATA0_ALIAS);
assign creg_mdata1_alias_dec =
   (addr_in[`IOB_LOCAL_ADDR_WIDTH-1:0] == `IOB_CREG_MDATA1_ALIAS);
assign creg_mbusy_alias_dec =
   (addr_in[`IOB_LOCAL_ADDR_WIDTH-1:0] == `IOB_CREG_MBUSY_ALIAS);
assign creg_mdata0_proper_dec =
   ((addr_in[`IOB_LOCAL_ADDR_WIDTH-1:0] & `IOB_THR_ADDR_MASK) == `IOB_CREG_MDATA0);
assign creg_mdata1_proper_dec =
   ((addr_in[`IOB_LOCAL_ADDR_WIDTH-1:0] & `IOB_THR_ADDR_MASK) == `IOB_CREG_MDATA1);
assign creg_mbusy_proper_dec =
   ((addr_in[`IOB_LOCAL_ADDR_WIDTH-1:0] & `IOB_THR_ADDR_MASK) == `IOB_CREG_MBUSY);
assign creg_mdata0_dec = creg_mdata0_proper_dec | creg_mdata0_alias_dec;
assign creg_mdata1_dec = creg_mdata1_proper_dec | creg_mdata1_alias_dec;
assign creg_mbusy_dec = creg_mbusy_proper_dec | creg_mbusy_alias_dec;
assign use_thr_addr = creg_mdata0_alias_dec |
                      creg_mdata1_alias_dec |
                      creg_mbusy_alias_dec;
assign mondo_data_addr = use_thr_addr ? thr_id_in :
                                         addr_in[`IOB_MONDO_DATA_INDEX-1+3:3];
assign addr_invld = ~creg_mdata0_dec &
                    ~creg_mdata1_dec &
                    ~creg_mbusy_dec;
endmodule