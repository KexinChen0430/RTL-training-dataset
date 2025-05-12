
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(0-1)+(size**1<<1):0] state;
  input  [size-1:0] grant;
  output [(0-1)+(size**1<<1):0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = 1+i)
          begin : ol2
            for (j = 0; j < size; j = j+1)
                begin : il2
                  assign new_state[i+(size*j)] = 
(state[i+(size*j)] && 
(grant[i] || 
(!grant[j] || (grant[i] && state[i+(size*j)])))) || grant[i];
                end
          end
  endgenerate

endmodule

