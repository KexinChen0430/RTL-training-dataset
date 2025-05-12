
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(WIDTH*HEIGHT)+(-1):0] in_states;
  output [(WIDTH*HEIGHT)+(-1):0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = 1+c)
          begin
            assign out_states[c] = 0;
            assign out_states[(((-1)+HEIGHT)*WIDTH)+c] = 0;
          end
      for (r = 1; r < ((-1)+HEIGHT); r = r+1)
          begin
            assign out_states[r*WIDTH] = 0;
            assign out_states[((r+1)*WIDTH)-1] = 0;
            for (c = 1; c < (WIDTH+(-1)); c = 1+c)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[c+(r*WIDTH)];
                  assign sum_i = (in_states[(c+(r*WIDTH))+(0-WIDTH)]+(in_states[(c+(r*WIDTH))+(-1)]+in_states[(c+(r*WIDTH))+1]))+((in_states[(c+(0-WIDTH))+((r*WIDTH)+(-1))]+in_states[((r*WIDTH)+(0-WIDTH))+(1+c)])+((in_states[((1+c)+WIDTH)+(r*WIDTH)]+in_states[WIDTH+(c+(r*WIDTH))])+in_states[(WIDTH+(c+(r*WIDTH)))-1]));
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == 1<<<1;
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = (((eq3_i | cur_state_i) & (~cur_state_i & (eq2_i | eq3_i))) | (~cur_state_i & (((eq2_i & cur_state_i) | (eq2_i | eq3_i)) & ((eq2_i & cur_state_i) | (((eq3_i & cur_state_i) | ~cur_state_i) & cur_state_i))))) | (((eq2_i & cur_state_i) | (eq2_i | eq3_i)) & ((eq2_i & cur_state_i) | (((eq3_i & cur_state_i) | ~cur_state_i) & cur_state_i)));
                  assign out_states[c+(r*WIDTH)] = next_state_i;
                end
          end
  endgenerate

endmodule

