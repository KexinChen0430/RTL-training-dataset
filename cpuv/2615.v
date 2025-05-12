module
    assign rd_addr_o = req_addr_i[12:2];
    assign rd_be_o = req_be_i[3:0];
    always @ (rd_be_o) begin
        casex (rd_be_o[3:0])
            4'b1xx1 : byte_count = 12'h004; 
            4'b01x1 : byte_count = 12'h003; 
            4'b1x10 : byte_count = 12'h003; 
            4'b0011 : byte_count = 12'h002; 
            4'b0110 : byte_count = 12'h002; 
            4'b1100 : byte_count = 12'h002; 
            4'b0001 : byte_count = 12'h001; 
            4'b0010 : byte_count = 12'h001; 
            4'b0100 : byte_count = 12'h001; 
            4'b1000 : byte_count = 12'h001; 
            4'b0000 : byte_count = 12'h001; 
        endcase
    end
    always @ (rd_be_o or req_addr_i or req_compl_wd_q) begin
        casex ({req_compl_wd_q, rd_be_o[3:0]})
            5'b0_xxxx : lower_addr = 8'h0; 
            5'bx_0000 : lower_addr = {req_addr_i[6:2], 2'b00}; 
            5'bx_xxx1 : lower_addr = {req_addr_i[6:2], 2'b00}; 
            5'bx_xx10 : lower_addr = {req_addr_i[6:2], 2'b01}; 
            5'bx_x100 : lower_addr = {req_addr_i[6:2], 2'b10}; 
            5'bx_1000 : lower_addr = {req_addr_i[6:2], 2'b11}; 
        endcase
    end
    always @ ( posedge clk ) begin
        if (!rst_n ) begin
            req_compl_q <= #TCQ 1'b0;
            req_compl_wd_q <= #TCQ 1'b1;
        end else begin
            req_compl_q <= #TCQ req_compl_i;
            req_compl_wd_q <= #TCQ req_compl_wd_i;
        end
    end
    always @ ( posedge clk ) begin
        if (!rst_n ) begin
            s_axis_tx_tlast   <= #TCQ 1'b0;
            s_axis_tx_tvalid  <= #TCQ 1'b0;
            s_axis_tx_tdata   <= #TCQ {C_DATA_WIDTH{1'b0}};
            s_axis_tx_tkeep   <= #TCQ {KEEP_WIDTH{1'b1}};
            compl_done_o      <= #TCQ 1'b0;
            state             <= #TCQ PIO_64_TX_RST_STATE;
        end else begin
            case ( state )
                PIO_64_TX_RST_STATE : begin
                    if (req_compl_q) begin
                        s_axis_tx_tlast  <= #TCQ 1'b0;
                        s_axis_tx_tvalid <= #TCQ 1'b1;
                        s_axis_tx_tdata  <= #TCQ {
                                              completer_id_i,           
                                              {3'b0},                   
                                              {1'b0},                   
                                              byte_count,               
                                              {1'b0},                   
                                              (req_compl_wd_q ?         
                                              PIO_64_CPLD_FMT_TYPE :    
                                              PIO_64_CPL_FMT_TYPE),     
                                              {1'b0},                   
                                              req_tc_i,                 
                                              {4'b0},                   
                                              req_td_i,                 
                                              req_ep_i,                 
                                              req_attr_i,               
                                              {2'b0},                   
                                              req_len_i                 
                                              };
                        s_axis_tx_tkeep   <= #TCQ 8'hFF; 
                        if (s_axis_tx_tready)
                            state <= #TCQ PIO_64_TX_CPLD_QW1; 
                        else
                            state <= #TCQ PIO_64_TX_RST_STATE; 
                    end else begin
                        s_axis_tx_tlast   <= #TCQ 1'b0;
                        s_axis_tx_tvalid  <= #TCQ 1'b0;
                        s_axis_tx_tdata   <= #TCQ 64'b0;
                        s_axis_tx_tkeep   <= #TCQ 8'hFF;
                        compl_done_o      <= #TCQ 1'b0;
                        state             <= #TCQ PIO_64_TX_RST_STATE;
                    end
                end
                PIO_64_TX_CPLD_QW1 : begin
                    if (s_axis_tx_tready) begin
                        s_axis_tx_tlast  <= #TCQ 1'b1;
                        s_axis_tx_tvalid <= #TCQ 1'b1;
                        s_axis_tx_tdata  <= #TCQ {
                                              rd_data_i,  
                                              req_rid_i,  
                                              req_tag_i,  
                                              {1'b0},     
                                              lower_addr  
                                              };
                        if (req_compl_wd_q)
                            s_axis_tx_tkeep <= #TCQ 8'hFF; 
                        else
                            s_axis_tx_tkeep <= #TCQ 8'h0F; 
                        compl_done_o      <= #TCQ 1'b1; 
                        state             <= #TCQ PIO_64_TX_RST_STATE; 
                    end else
                        state <= #TCQ PIO_64_TX_CPLD_QW1; 
                end
            endcase
        end
    end
endmodule