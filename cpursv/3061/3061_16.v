
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(size**1<<1)-1:0] state;
  input  [(-1)+size:0] grant;
  output [(size**1<<1)-1:0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = i+1)
          begin : ol2
            for (j = 0; j < size; j = 1+j)
                begin : il2
                  assign new_state[i+(size*j)] = (state[i+(size*j)] && !grant[j]) || 
                                 (grant[i] && state[i+(size*j)]) || 
                                 ((!grant[j] && grant[i]) || 
(
((state[i+(size*j)] && !grant[j]) || 
(grant[i] && state[i+(size*j)])) && (!grant[j] && grant[i])) || (grant[i] && state[i+(size*j)])) || grant[i];
                end
          end
  endgenerate

endmodule

