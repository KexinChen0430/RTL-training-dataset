module
    assign rd_data =
    (r_rd_addr >= 8) ? ~(1'b0) :
    data[r_rd_addr];
endmodule