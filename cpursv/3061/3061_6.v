
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(size**1<<1)-1:0] state;
  input  [(-1)+size:0] grant;
  output [(size**1<<1)-1:0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = 1+i)
          begin : ol2
            for (j = 0; j < size; j = 1+j)
                begin : il2
                  assign new_state[i+(j*size)] = grant[i] || 
                                 ((grant[i] && state[i+(j*size)]) || 
(!grant[j] && grant[i]) || (!grant[j] && state[i+(j*size)]));
                end
          end
  endgenerate

endmodule

