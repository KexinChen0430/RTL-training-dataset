module cannot_stall 
assign id_ex_ack = ex_mem_rdy; 
assign ex_mem_rdy = ex_mem_rdy_reg; 
always @ (posedge clk, negedge rstn) begin 
    if (~rstn) begin 
        ex_mem_rdy_reg     <= 1'b0; 
        ex_mem_result  <= 'h0; 
        ex_mem_funct   <= `MEM_NOP; 
        ex_mem_data    <= 'h0; 
        ex_mem_wb_rsd  <= 'h0; 
    end
    else begin 
        if (ex_mem_rdy_reg && ex_mem_ack) begin 
            ex_mem_rdy_reg     <= id_ex_rdy; 
            ex_mem_result  <= result; 
            ex_mem_funct   <= id_ex_mem_funct; 
            ex_mem_data    <= id_ex_mem_data; 
            ex_mem_wb_rsd  <= id_ex_wb_rsd; 
        end
    end
end
endmodule 