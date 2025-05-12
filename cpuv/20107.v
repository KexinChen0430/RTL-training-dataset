module d_CS_evaluation_matrix_slot_005_alpha_to_007(i_in, o_out); 
input wire [`D_CS_GF_ORDER-1:0] i_in; 
output wire [`D_CS_GF_ORDER-1:0] o_out; 
assign o_out[0] = i_in[0] ^ i_in[3] ^ i_in[4] ^ i_in[9] ^ i_in[10]; 
assign o_out[1] = i_in[0] ^ i_in[1] ^ i_in[4] ^ i_in[5] ^ i_in[10] ^ i_in[11]; 
endmodule 