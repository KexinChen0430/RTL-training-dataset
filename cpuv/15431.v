module acl_ic_master_endpoint
#(
    parameter integer DATA_W = 32,              
    parameter integer BURSTCOUNT_W = 4,         
    parameter integer ADDRESS_W = 32,           
    parameter integer BYTEENA_W = DATA_W / 8,   
    parameter integer ID_W = 1,                 
    parameter integer TOTAL_NUM_MASTERS = 1,    
    parameter integer ID = 0                    
)
(
    input logic clock,                          
    input logic resetn,                         
    acl_ic_master_intf m_intf,                  
    acl_arb_intf arb_intf,                      
    acl_ic_wrp_intf wrp_intf,                   
    acl_ic_rrp_intf rrp_intf                    
);
    assign arb_intf.req = m_intf.arb.req;       
    assign m_intf.arb.stall = arb_intf.stall;   
    generate
    if( TOTAL_NUM_MASTERS > 1 )                 
    begin
        logic [ID_W-1:0] id = ID;               
        assign m_intf.wrp.ack = wrp_intf.ack & (wrp_intf.id == id); 
        assign m_intf.rrp.datavalid = rrp_intf.datavalid & (rrp_intf.id == id); 
        assign m_intf.rrp.data = rrp_intf.data; 
    end
    else 
    begin
        assign m_intf.wrp.ack = wrp_intf.ack;   
        assign m_intf.rrp.datavalid = rrp_intf.datavalid; 
        assign m_intf.rrp.data = rrp_intf.data; 
    end
    endgenerate
endmodule 