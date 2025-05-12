module 
assign if_freeze = if_stall | id_freeze; 
assign id_freeze = ex_freeze; 
assign ex_freeze = wb_freeze | asyn_stall; 
assign wb_freeze = lsu_stall | multicycle_stall; 
assign wb_freeze_a = lsu_stall | multicycle_stall; 
assign wb_freeze = wb_freeze_a | wb_atfze; 
always @(posedge clk or posedge rst) begin
    if (rst)
        wb_atfze <= #1 1'b0; 
    else if(wb_freeze_a)
        wb_atfze <= #1 rfwb_uops[0] & rfwb_uops[1]; 
    else
        wb_atfze <= #1 1'b0; 
end
assign wb_freeze_a = lsu_stall | multicycle_stall; 
assign wb_freeze = wb_freeze_a | wb_atfze; 
always @(posedge clk or posedge rst) begin
    if (rst)
        wb_atfze <= #1 1'b0; 
    else if(!wb_freeze_a)
        wb_atfze <= #1 rfwb_uops[0] & rfwb_uops[1]; 
end
endmodule 