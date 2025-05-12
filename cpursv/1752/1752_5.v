
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(0-1)+(HEIGHT*WIDTH):0] in_states;
  output [(0-1)+(HEIGHT*WIDTH):0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = 1+c)
          begin
            assign out_states[c] = 0;
            assign out_states[(WIDTH*(HEIGHT+(0-1)))+c] = 0;
          end
      for (r = 1; r < (HEIGHT+(0-1)); r = 1+r)
          begin
            assign out_states[WIDTH*r] = 0;
            assign out_states[(0-1)+((1+r)*WIDTH)] = 0;
            for (c = 1; c < (WIDTH-1); c = 1+c)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[c+(WIDTH*r)];
                  assign sum_i = (((in_states[(c+(WIDTH*r))+WIDTH]+in_states[1+((c+(WIDTH*r))+WIDTH)])+in_states[1+(c+(WIDTH*r))])+in_states[((c+(WIDTH*r))+WIDTH)+(0-1)])+((in_states[(((-WIDTH)+1)+(WIDTH*r))+c]+in_states[((c+(WIDTH*r))+(0-1))+(-WIDTH)])+(in_states[(-WIDTH)+(c+(WIDTH*r))]+in_states[(c+(WIDTH*r))+(0-1)]));
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == (1+1);
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = (((cur_state_i | ~cur_state_i) & eq2_i) & cur_state_i) | eq3_i;
                  assign out_states[c+(WIDTH*r)] = next_state_i;
                end
          end
  endgenerate

endmodule

