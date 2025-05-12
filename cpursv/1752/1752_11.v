
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(WIDTH*HEIGHT)-1:0] in_states;
  output [(WIDTH*HEIGHT)-1:0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = 1+c)
          begin
            assign out_states[c] = 0;
            assign out_states[c+((HEIGHT+(0-1))*WIDTH)] = 0;
          end
      for (r = 1; r < (HEIGHT+(0-1)); r = r+1)
          begin
            assign out_states[r*WIDTH] = 0;
            assign out_states[((r+1)*WIDTH)+(0-1)] = 0;
            for (c = 1; c < (WIDTH-1); c = 1+c)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[(r*WIDTH)+c];
                  assign sum_i = ((in_states[(1+c)+((r*WIDTH)+(0-WIDTH))]+(in_states[(c+(0-1))+((r*WIDTH)+(0-WIDTH))]+in_states[(0-WIDTH)+((r*WIDTH)+c)]))+(in_states[((r*WIDTH)+c)-1]+(in_states[(((r*WIDTH)+c)-1)+WIDTH]+in_states[WIDTH+((r*WIDTH)+c)])))+(in_states[(r*WIDTH)+(1+c)]+in_states[((r*WIDTH)+(1+c))+WIDTH]);
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == (1+1);
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = ((eq3_i & cur_state_i) | (eq2_i & cur_state_i)) | eq3_i;
                  assign out_states[(r*WIDTH)+c] = next_state_i;
                end
          end
  endgenerate

endmodule

