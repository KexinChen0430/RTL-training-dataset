
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(HEIGHT*WIDTH)+(0-1):0] in_states;
  output [(HEIGHT*WIDTH)+(0-1):0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = c+1)
          begin
            assign out_states[c] = 0;
            assign out_states[((HEIGHT-1)*WIDTH)+c] = 0;
          end
      for (r = 1; r < (HEIGHT-1); r = 1+r)
          begin
            assign out_states[r*WIDTH] = 0;
            assign out_states[(0-1)+((1+r)*WIDTH)] = 0;
            for (c = 1; c < (WIDTH+(0-1)); c = c+1)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[c+(r*WIDTH)];
                  assign sum_i = ((in_states[c+((r*WIDTH)+(WIDTH+1))]+in_states[(WIDTH+(0-1))+(c+(r*WIDTH))])+in_states[(WIDTH+(r*WIDTH))+c])+(((in_states[(c+((-WIDTH)+(0-1)))+(r*WIDTH)]+in_states[(0-1)+(c+(r*WIDTH))])+in_states[c+((r*WIDTH)+(-WIDTH))])+(in_states[(c+1)+(r*WIDTH)]+in_states[(r*WIDTH)+(((-WIDTH)+1)+c)]));
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == (1+1);
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = (eq2_i | eq3_i) & (eq3_i | cur_state_i);
                  assign out_states[c+(r*WIDTH)] = next_state_i;
                end
          end
  endgenerate

endmodule

