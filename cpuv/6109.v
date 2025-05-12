module
    if (ftdi_txe_n == 0)  begin
        ftdi_wr_n <= 0;
        regout_addrvalid <= 1;
        bytecnt <= bytecnt + 16'd1;
        state <= `DATARD2;
    end else begin
        ftdi_wr_n <= 1;
        regout_addrvalid <= 1;
    end
end else begin
    if ((bytecnt != (total_bytes-16'd1)))  begin
        state <= `IDLE;
        regout_addrvalid <= 0;
        ftdi_wr_n <= 1;
    end else begin
        if (ftdi_txe_n == 0) begin
            ftdi_wr_n <= 0;
            regout_addrvalid <= 1;
            state <= `IDLE;
        end else begin
            regout_addrvalid <= 1;
            ftdi_wr_n <= 1;
        end
    end
end
`DATARD2: begin
    ftdi_isOutput <= 1;
    ftdi_rd_n <= 1;
    ftdi_wr_n <= 1;
    regout_write <= 0;
    regout_read <= 1;
    regout_addrvalid <= 1;
    state <= `DATARD1;
end
default: begin
    regout_addrvalid <= 0;
    ftdi_rd_n <= 1;
    ftdi_wr_n <= 1;
    ftdi_isOutput <= 0;
    regout_read <= 0;
    state <= `IDLE;
end
endcase
end
`ifdef CHIPSCOPE
assign cs_data[3:0] = state;
assign cs_data[11:4] = address;
assign cs_data[12] = ftdi_rxf_n;
assign cs_data[13] = ftdi_txe_n;
assign cs_data[14] = ftdi_rd_n;
assign cs_data[15] = ftdi_wr_n;
assign cs_data[32:25] = ftdi_dout;
assign cs_data[43:36] = ftdi_din;
assign cs_data[51:44] = total_bytes;
assign cs_data[67:52] = bytecnt;
assign cs_data[16] = regout_read;
assign cs_data[75:68] = reg_datai;
`endif
endmodule