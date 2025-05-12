module uparc_fwdu(
    rs,
    rs_data,
    rt,
    rt_data,
    rd_p2,
    rd_data_p2,
    pend_mem_load_p2,
    rd_p3,
    rd_data_p3,
    rs_data_p1,
    rt_data_p1
);
input wire [`UPARC_REGNO_WIDTH-1:0]    rs;         
input wire [`UPARC_REG_WIDTH-1:0]    rs_data;     
input wire [`UPARC_REGNO_WIDTH-1:0]    rt;         
input wire [`UPARC_REG_WIDTH-1:0]    rt_data;     
input wire [`UPARC_REGNO_WIDTH-1:0]    rd_p2;      
input wire [`UPARC_REG_WIDTH-1:0]    rd_data_p2;  
input wire                pend_mem_load_p2;        
input wire [`UPARC_REGNO_WIDTH-1:0]    rd_p3;      
input wire [`UPARC_REG_WIDTH-1:0]    rd_data_p3;  
output reg [`UPARC_REG_WIDTH-1:0]    rs_data_p1;  
output reg [`UPARC_REG_WIDTH-1:0]    rt_data_p1;  
always @(*)
begin
    if(|rs && rs == rd_p2)                        
        rs_data_p1 = rd_data_p2;                  
    else if(|rs && rs == rd_p3)                   
        rs_data_p1 = rd_data_p3;                  
    else
        rs_data_p1 = rs_data;                     
end
always @(*)
begin
    if(|rt && rt == rd_p2 && !pend_mem_load_p2)   
        rt_data_p1 = rd_data_p2;                  
    else if(|rt && rt == rd_p3)                   
        rt_data_p1 = rd_data_p3;                  
    else
        rt_data_p1 = rt_data;                     
end
endmodule