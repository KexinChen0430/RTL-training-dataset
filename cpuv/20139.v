module d_SC_evaluation_matrix_022(i_in, o_out);
    input wire [11:0] i_in;
    output wire [`D_SC_GF_ORDER-1:0] o_out;
    assign o_out[0] = i_in[0] ^ i_in[1] ^ i_in[2] ^ i_in[3] ^ i_in[4] ^ i_in[6] ^ i_in[7] ^ i_in[8];
    assign o_out[1] = i_in[1] ^ i_in[3] ^ i_in[8] ^ i_in[9] ^ i_in[11];
    assign o_out[2] = i_in[1] ^ i_in[3] ^ i_in[5] ^ i_in[6] ^ i_in[7] ^ i_in[9] ^ i_in[10] ^ i_in[11];
    assign o_out[3] = i_in[1] ^ i_in[2] ^ i_in[3] ^ i_in[6] ^ i_in[7] ^ i_in[8];
    assign o_out[4] = i_in[2] ^ i_in[4] ^ i_in[7] ^ i_in[9];
    assign o_out[5] = i_in[1] ^ i_in[2] ^ i_in[4] ^ i_in[5] ^ i_in[6] ^ i_in[7] ^ i_in[9] ^ i_in[11];
    assign o_out[6] = i_in[1] ^ i_in[2] ^ i_in[5] ^ i_in[6] ^ i_in[8];
    assign o_out[7] = i_in[1] ^ i_in[2] ^ i_in[3] ^ i_in[4] ^ i_in[10];
    assign o_out[8] = i_in[2] ^ i_in[3] ^ i_in[4] ^ i_in[5] ^ i_in[6] ^ i_in[8] ^ i_in[11];
    assign o_out[9] = i_in[2] ^ i_in[3] ^ i_in[5] ^ i_in[7] ^ i_in[8] ^ i_in[9] ^ i_in[10];
    assign o_out[10] = i_in[1] ^ i_in[3] ^ i_in[4] ^ i_in[6] ^ i_in[8] ^ i_in[9] ^ i_in[10];
    assign o_out[11] = i_in[2] ^ i_in[3] ^ i_in[4] ^ i_in[5] ^ i_in[7] ^ i_in[10] ^ i_in[11];
endmodule