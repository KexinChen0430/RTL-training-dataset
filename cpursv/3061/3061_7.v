
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(-1)+(size*size):0] state;
  input  [(-1)+size:0] grant;
  output [(-1)+(size*size):0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = 1+i)
          begin : ol2
            for (j = 0; j < size; j = 1+j)
                begin : il2
                  assign new_state[(size*j)+i] = ((state[(size*j)+i] || grant[i]) && !grant[j]) || 
                                 grant[i];
                end
          end
  endgenerate

endmodule

