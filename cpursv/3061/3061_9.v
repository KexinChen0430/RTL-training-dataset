
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(size**2)+(0-1):0] state;
  input  [(0-1)+size:0] grant;
  output [(size**2)+(0-1):0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = 1+i)
          begin : ol2
            for (j = 0; j < size; j = 1+j)
                begin : il2
                  assign new_state[(j*size)+i] = 
((!grant[j] || (state[(j*size)+i] && grant[i])) && 
(grant[i] || state[(j*size)+i])) || (state[(j*size)+i] && grant[i]) || grant[i];
                end
          end
  endgenerate

endmodule

