module  ecc_check_pipe (
                        input logic        clk,
                        input logic        bank_rd_m3,
                        input logic [32:0] data_i,
                        output logic       ecc_err_o
                        );
   logic [3:0]                             check_group_6_0;
   logic                                   check_group_6_0_q;
   always_comb check_group_6_0 = {data_i[0], data_i[2], data_i[4], data_i[7] };
   always_ff @(posedge clk) if (bank_rd_m3)  check_group_6_0_q <=^check_group_6_0;
   assign ecc_err_o = check_group_6_0_q;
endmodule