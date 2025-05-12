module cannot_stall (
);
assign ex_mem_ack = mem_wb_rdy;
assign mem_wb_rdy = mem_wb_rdy_reg & (~data_req | data_bif_ack);
always @ (*) begin
    case (ex_mem_funct)
        `MEM_SB : waddr_mask = 4'b0001; 
        `MEM_SH : waddr_mask = 4'b0011; 
        `MEM_SW : waddr_mask = 4'b1111; 
        default : waddr_mask = 4'b0000; 
    endcase
end
always @ (posedge clk, negedge rstn) begin
    if (~rstn) begin
        mem_wb_rdy_reg <= 1'b0;          
        mem_wb_funct   <= `LD_NOP;       
        mem_wb_data    <= 'h0;           
        mem_wb_rsd     <= 'h0;           
    end
    else begin
        if (mem_wb_rdy && mem_wb_ack) begin
            mem_wb_rdy_reg <= ex_mem_rdy;                         
            mem_wb_funct   <= ex_mem_funct[`LD_FUNCT_W-1:0];      
            mem_wb_data    <= ex_mem_data;                        
            mem_wb_rsd     <= ex_mem_wb_rsd;                      
        end
    end
end
endmodule 