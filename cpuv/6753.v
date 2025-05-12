module tb (); 
reg tb_clk  = 1'b0; 
reg tb_rstn = 1'b0; 
always @ (posedge clk) begin 
end 
always @ (posedge clk) begin 
    if (~tb_rstn) begin 
        check_fifo_flush <= 1'b1; 
    end
    else begin 
        check_fifo_flush <= 1'b0; 
        check_fifo_read  <= 1'b0; 
        if (us_rdy && us_ack) begin 
            if (check_fifo_empty) begin 
                $display("ERROR: DUT output rdy but no data in check fifo"); 
                $finish(); 
            end
            else begin 
                check_fifo_mem_funct  = check_fifo_rdata[`CHECK_FIFO_MEM_FUNCT_RANGE];
                check_fifo_mem_data   = check_fifo_rdata[`CHECK_FIFO_MEM_DATA_RANGE ];
                check_fifo_mem_result = check_fifo_rdata[`CHECK_FIFO_RESULT_RANGE   ];
                check_fifo_wb_rsd     = check_fifo_rdata[`CHECK_FIFO_WB_RSD_RANGE   ];
                check_fifo_trans_cnt  = check_fifo_rdata[`CHECK_FIFO_TRANS_CNT_RANGE];
            end
        end
    end
end
endmodule 