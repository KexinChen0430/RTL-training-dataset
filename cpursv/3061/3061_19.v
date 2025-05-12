
module comb_matrix_arb_next_state(state,grant,new_state);

  parameter  size = 4;
  input  [(size**1<<<1)+(0-1):0] state;
  input  [(0-1)+size:0] grant;
  output [(size**1<<<1)+(0-1):0] new_state;

  genvar i,j;
  
  generate
      for (i = 0; i < size; i = 1+i)
          begin : ol2
            for (j = 0; j < size; j = j+1)
                begin : il2
                  assign new_state[(j*size)+i] = 
((grant[i] || !grant[j]) && 
((grant[i] && !grant[j]) || state[(j*size)+i])) || grant[i];
                end
          end
  endgenerate

endmodule

