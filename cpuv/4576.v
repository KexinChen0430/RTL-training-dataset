module sys_sm_seq(
    clk,            
    rstn,           
    overrun_next,   
    sys_sm_next,    
    channel_next,   
    overrun_cur,    
    sys_sm_cur,     
    channel_cur     
);
    input clk;
    input rstn;
    input overrun_next;
    input [2:0] sys_sm_next;
    input [1:0] channel_next;
    output reg overrun_cur;
    output reg [2:0] sys_sm_cur;
    output reg [1:0] channel_cur;
    always @(posedge clk or negedge rstn) begin
        if(rstn == 0) begin
            channel_cur <= 0;          
            overrun_cur <= 0;          
            sys_sm_cur <= `ATTN_CHECK; 
        end else begin
            overrun_cur <= overrun_next; 
            channel_cur <= channel_next; 
            sys_sm_cur <= sys_sm_next;   
        end
    end
endmodule