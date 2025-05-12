
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(0-1)+(HEIGHT*WIDTH):0] in_states;
  output [(0-1)+(HEIGHT*WIDTH):0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = c+1)
          begin
            assign out_states[c] = 0;
            assign out_states[(WIDTH*(HEIGHT+(0-1)))+c] = 0;
          end
      for (r = 1; r < (HEIGHT+(0-1)); r = r+1)
          begin
            assign out_states[WIDTH*r] = 0;
            assign out_states[(0-1)+(WIDTH*(r+1))] = 0;
            for (c = 1; c < ((0-1)+WIDTH); c = c+1)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[(WIDTH*r)+c];
                  assign sum_i = ((in_states[c+(1+(WIDTH*r))]+in_states[((WIDTH*r)+c)+(-WIDTH)])+((in_states[(c+(1+(WIDTH*r)))+(-WIDTH)]+in_states[c+((WIDTH*r)+(0-1))])+in_states[c+((WIDTH*r)+((-WIDTH)+(0-1)))]))+(in_states[(c+WIDTH)+(1+(WIDTH*r))]+(in_states[((WIDTH*r)+WIDTH)+((0-1)+c)]+in_states[(c+WIDTH)+(WIDTH*r)]));
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == 2;
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = ((eq3_i & cur_state_i) | ((((eq3_i | eq2_i) | ~cur_state_i) & cur_state_i) & eq2_i)) | eq3_i;
                  assign out_states[(WIDTH*r)+c] = next_state_i;
                end
          end
  endgenerate

endmodule

