module acl_avm_to_ic #(
    parameter integer DATA_W = 256,          
    parameter integer WRITEDATA_W = 256,     
    parameter integer BURSTCOUNT_W = 6,      
    parameter integer ADDRESS_W = 32,        
    parameter integer BYTEENA_W = DATA_W / 8,
    parameter integer ID_W = 1,              
    parameter ADDR_SHIFT=1                   
)
(
    input logic avm_enable,                  
    input logic avm_read,                    
    input logic avm_write,                   
    input logic [WRITEDATA_W-1:0] avm_writedata, 
    input logic [BURSTCOUNT_W-1:0] avm_burstcount, 
    input logic [ADDRESS_W-1:0] avm_address, 
    input logic [BYTEENA_W-1:0] avm_byteenable, 
    output logic avm_waitrequest,            
    output logic avm_readdatavalid,          
    output logic [WRITEDATA_W-1:0] avm_readdata, 
    output logic avm_writeack,               
    output logic ic_arb_request,             
    output logic ic_arb_enable,              
    output logic ic_arb_read,                
    output logic ic_arb_write,               
    output logic [WRITEDATA_W-1:0] ic_arb_writedata, 
    output logic [BURSTCOUNT_W-1:0] ic_arb_burstcount, 
    output logic [ADDRESS_W-$clog2(DATA_W / 8)-1:0] ic_arb_address, 
    output logic [BYTEENA_W-1:0] ic_arb_byteenable, 
    output logic [ID_W-1:0] ic_arb_id,      
    input logic ic_arb_stall,                
    input logic ic_wrp_ack,                  
    input logic ic_rrp_datavalid,            
    input logic [WRITEDATA_W-1:0] ic_rrp_data 
);
    assign ic_arb_request = avm_read | avm_write;
    assign ic_arb_read = avm_read;           
    assign ic_arb_write = avm_write;         
    assign ic_arb_writedata = avm_writedata; 
    assign ic_arb_burstcount = avm_burstcount; 
    assign ic_arb_id = {ID_W{1'bx}};         
    assign ic_arb_enable = avm_enable;
    generate
    if(ADDR_SHIFT==1)
    begin
        assign ic_arb_address = avm_address[ADDRESS_W-1:$clog2(DATA_W / 8)];
    end
    else
    begin
        assign ic_arb_address = avm_address[ADDRESS_W-$clog2(DATA_W / 8)-1:0];
    end
    endgenerate
    assign ic_arb_byteenable = avm_byteenable;
    assign avm_waitrequest = ic_arb_stall;
    assign avm_readdatavalid = ic_rrp_datavalid;
    assign avm_readdata = ic_rrp_data;
    assign avm_writeack = ic_wrp_ack;
endmodule