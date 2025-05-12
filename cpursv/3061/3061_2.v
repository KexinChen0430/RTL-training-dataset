
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(size**1<<1)+(0-1):0] state;
  input  [size-1:0] grant;
  output [(size**1<<1)+(0-1):0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = i+1)
          begin : ol2
            for (j = 0; j < size; j = 1+j)
                begin : il2
                  assign new_state[(size*j)+i] = grant[i] || 
                                 ((state[(size*j)+i] || grant[i]) && 
((grant[i] && state[(size*j)+i]) || !grant[j]));
                end
          end
  endgenerate

endmodule

