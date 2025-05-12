module acl_ic_to_avm #(
    parameter integer DATA_W = 256, 
    parameter integer BURSTCOUNT_W = 6, 
    parameter integer ADDRESS_W = 32, 
    parameter integer BYTEENA_W = DATA_W / 8, 
    parameter integer ID_W = 1 
)
(
    output logic avm_enable, 
    output logic avm_read, 
    output logic avm_write, 
    output logic [DATA_W-1:0] avm_writedata, 
    output logic [BURSTCOUNT_W-1:0] avm_burstcount, 
    output logic [ADDRESS_W-1:0] avm_address, 
    output logic [BYTEENA_W-1:0] avm_byteenable, 
    input logic avm_waitrequest, 
    input logic avm_readdatavalid, 
    input logic [DATA_W-1:0] avm_readdata, 
    input logic avm_writeack,   
    input logic ic_arb_request, 
    input logic ic_arb_enable, 
    input logic ic_arb_read, 
    input logic ic_arb_write, 
    input logic [DATA_W-1:0] ic_arb_writedata, 
    input logic [BURSTCOUNT_W-1:0] ic_arb_burstcount, 
    input logic [ADDRESS_W-$clog2(DATA_W / 8)-1:0] ic_arb_address, 
    input logic [BYTEENA_W-1:0] ic_arb_byteenable, 
    input logic [ID_W-1:0] ic_arb_id, 
    output logic ic_arb_stall, 
    output logic ic_wrp_ack, 
    output logic ic_rrp_datavalid, 
    output logic [DATA_W-1:0] ic_rrp_data 
);
    assign avm_read = ic_arb_read; 
    assign avm_write = ic_arb_write; 
    assign avm_writedata = ic_arb_writedata; 
    assign avm_burstcount = ic_arb_burstcount; 
    assign avm_address = {ic_arb_address, {$clog2(DATA_W / 8){1'b0}}};
    assign avm_byteenable = ic_arb_byteenable; 
    assign ic_arb_stall = avm_waitrequest; 
    assign ic_rrp_datavalid = avm_readdatavalid; 
    assign ic_rrp_data = avm_readdata; 
    assign ic_wrp_ack = avm_write & ~avm_waitrequest;
endmodule 