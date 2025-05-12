
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(0-1)+(HEIGHT*WIDTH):0] in_states;
  output [(0-1)+(HEIGHT*WIDTH):0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = c+1)
          begin
            assign out_states[c] = 0;
            assign out_states[c+(WIDTH*(HEIGHT-1))] = 0;
          end
      for (r = 1; r < (HEIGHT-1); r = r+1)
          begin
            assign out_states[r*WIDTH] = 0;
            assign out_states[((r+1)*WIDTH)+(0-1)] = 0;
            for (c = 1; c < (WIDTH-1); c = c+1)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[(r*WIDTH)+c];
                  assign sum_i = (((in_states[(c+(-WIDTH))+((0-1)+(r*WIDTH))]+in_states[(r*WIDTH)+(c+(-WIDTH))])+in_states[c+((0-1)+(r*WIDTH))])+(in_states[c+((r*WIDTH)+WIDTH)]+in_states[(1+((r*WIDTH)+c))+WIDTH]))+(in_states[((r*WIDTH)+(-WIDTH))+(c+1)]+(in_states[1+((r*WIDTH)+c)]+in_states[((r*WIDTH)+(WIDTH-1))+c]));
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == 2;
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = (eq2_i & ((cur_state_i & eq3_i) | ((eq2_i | ~cur_state_i) & cur_state_i))) | eq3_i;
                  assign out_states[(r*WIDTH)+c] = next_state_i;
                end
          end
  endgenerate

endmodule

