module
    assign rd_addr_o = req_addr_i[12:2];
    assign rd_be_o =   req_be_i[3:0];
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
    always @ (rd_be_o or req_addr_i) begin
      casex (rd_be_o[3:0])
        4'b0000 : lower_addr = {req_addr_i[6:2], 2'b00};
        4'bxxx1 : lower_addr = {req_addr_i[6:2], 2'b00};
        4'bxx10 : lower_addr = {req_addr_i[6:2], 2'b01};
        4'bx100 : lower_addr = {req_addr_i[6:2], 2'b10};
        4'b1000 : lower_addr = {req_addr_i[6:2], 2'b11};
      endcase
    end
    always @ ( posedge clk or negedge rst_n ) begin
        if (!rst_n ) begin
          req_compl_q <= 1'b0;
          req_compl_with_data_q <= 1'b1;
        end else begin
          req_compl_q <= req_compl_i;
          req_compl_with_data_q <= req_compl_with_data_i;
        end
    end
    always @ ( posedge clk or negedge rst_n ) begin
        if (!rst_n ) begin
          trn_tsof_n        <= 1'b1;
          trn_teof_n        <= 1'b1;
          trn_tsrc_rdy_n    <= 1'b1;
          trn_tsrc_dsc_n    <= 1'b1;
          trn_td            <= 64'b0;
          trn_trem_n        <= 8'b0;
          compl_done_o      <= 1'b0;
          state             <= `PIO_64_TX_RST_STATE;
        end else begin
          case ( state )
            `PIO_64_TX_RST_STATE : begin
              if (req_compl_q && req_compl_with_data_q &&
                  trn_tdst_dsc_n) begin
                trn_tsof_n       <= 1'b0;
                trn_teof_n       <= 1'b1;
                trn_tsrc_rdy_n   <= 1'b0;
                trn_td           <= { {1'b0},
                                      `PIO_64_CPLD_FMT_TYPE,
                                      {1'b0},
                                      req_tc_i,
                                      {4'b0},
                                      req_td_i,
                                      req_ep_i,
                                      req_attr_i,
                                      {2'b0},
                                      req_len_i,
                                      completer_id_i,
                                      {3'b0},
                                      {1'b0},
                                      byte_count };
                trn_trem_n        <= 8'b0;
                state             <= `PIO_64_TX_CPLD_QW1;
              end else if (req_compl_q && (!req_compl_with_data_q) &&
                  trn_tdst_dsc_n) begin
                trn_tsof_n       <= 1'b0;
                trn_teof_n       <= 1'b1;
                trn_tsrc_rdy_n   <= 1'b0;
                trn_td           <= { {1'b0},
                                      `PIO_64_CPL_FMT_TYPE,
                                      {1'b0},
                                      req_tc_i,
                                      {4'b0},
                                      req_td_i,
                                      req_ep_i,
                                      req_attr_i,
                                      {2'b0},
                                      req_len_i,
                                      completer_id_i,
                                      {3'b0},
                                      {1'b0},
                                      byte_count };
                trn_trem_n        <= 8'b0;
                state             <= `PIO_64_TX_CPL_QW1;
              end else begin
                trn_tsof_n        <= 1'b1;
                trn_teof_n        <= 1'b1;
                trn_tsrc_rdy_n    <= 1'b1;
                trn_tsrc_dsc_n    <= 1'b1;
                trn_td            <= 64'b0;
                trn_trem_n        <= 8'b0;
                compl_done_o      <= 1'b0;
                state             <= `PIO_64_TX_RST_STATE;
              end
            end
            `PIO_64_TX_CPLD_QW1 : begin
              if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n)) begin
                trn_tsof_n       <= 1'b1;
                trn_teof_n       <= 1'b0;
                trn_tsrc_rdy_n   <= 1'b0;
                trn_td           <= { req_rid_i,
                                      req_tag_i,
                                      {1'b0},
                                      lower_addr,
                                      rd_data_i };
                trn_trem_n        <= 8'h00;
                compl_done_o      <= 1'b1;
                state             <= `PIO_64_TX_RST_STATE;
              end else if (!trn_tdst_dsc_n) begin
                state             <= `PIO_64_TX_RST_STATE;
                trn_tsrc_dsc_n    <= 1'b0;
              end else
                state             <= `PIO_64_TX_CPLD_QW1;
            end
            `PIO_64_TX_CPL_QW1 : begin
              if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n)) begin
                trn_tsof_n       <= 1'b1;
                trn_teof_n       <= 1'b0;
                trn_tsrc_rdy_n   <= 1'b0;
                trn_td           <= { req_rid_i,
                                      req_tag_i,
                                      {1'b0},
                                      lower_addr,
                                      32'h00000000 };
                trn_trem_n        <= 8'h0F;
                compl_done_o      <= 1'b1;
                state             <= `PIO_64_TX_RST_STATE;
              end else if (!trn_tdst_dsc_n) begin
                state             <= `PIO_64_TX_RST_STATE;
                trn_tsrc_dsc_n    <= 1'b0;
              end else
                state             <= `PIO_64_TX_CPL_QW1;
            end
          endcase
        end
    end
endmodule