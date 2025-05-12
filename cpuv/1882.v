module uparc_writeback(
    clk,                
    nrst,               
    i_exec_stall,       
    i_mem_stall,        
    i_fetch_stall,      
    i_wait_stall,       
    i_nullify,          
    i_rd_no,            
    i_rd_val,           
    o_rd_no,            
    o_rd_val            
);
input wire clk;                
input wire nrst;               
input wire i_exec_stall;       
input wire i_mem_stall;        
input wire i_fetch_stall;      
input wire i_wait_stall;       
input wire i_nullify;          
input wire [`UPARC_REGNO_WIDTH-1:0] i_rd_no;   
input wire [`UPARC_REG_WIDTH-1:0] i_rd_val;    
output reg [`UPARC_REGNO_WIDTH-1:0] o_rd_no;   
output reg [`UPARC_REG_WIDTH-1:0] o_rd_val;    
wire core_stall = i_exec_stall || i_mem_stall || i_fetch_stall || i_wait_stall;
always @(posedge clk or negedge nrst)
begin
    if(!nrst) 
    begin
        o_rd_no <= {(`UPARC_REGNO_WIDTH){1'b0}};
        o_rd_val <= {(`UPARC_REG_WIDTH){1'b0}};
    end
    else if(!core_stall) 
    begin
        o_rd_no <= !i_nullify ? i_rd_no : {(`UPARC_REGNO_WIDTH){1'b0}};
        o_rd_val <= i_rd_val;
    end
end
endmodule 