
module conway  #(parameter  WIDTH = 32, HEIGHT = 32)
  (in_states,out_states);

  input  [(HEIGHT*WIDTH)-1:0] in_states;
  output [(HEIGHT*WIDTH)-1:0] out_states;

  genvar r,c;
  
  generate
      for (c = 0; c < WIDTH; c = 1+c)
          begin
            assign out_states[c] = 0;
            assign out_states[((HEIGHT-1)*WIDTH)+c] = 0;
          end
      for (r = 1; r < (HEIGHT-1); r = 1+r)
          begin
            assign out_states[WIDTH*r] = 0;
            assign out_states[((1+r)*WIDTH)-1] = 0;
            for (c = 1; c < (WIDTH-1); c = 1+c)
                begin
                  wire cur_state_i;

                  wire [4:0] sum_i;

                  assign cur_state_i = in_states[(WIDTH*r)+c];
                  assign sum_i = (((in_states[((WIDTH*r)+c)+(-WIDTH)]+(in_states[(((WIDTH*r)+c)+(-WIDTH))+(-1)]+in_states[c+(((-WIDTH)+1)+(WIDTH*r))]))+(in_states[(WIDTH+c)+(WIDTH*r)]+in_states[(WIDTH*r)+((WIDTH+1)+c)]))+in_states[((WIDTH*r)+c)+(-1)])+(in_states[((WIDTH*r)+c)+1]+in_states[((WIDTH+c)+(WIDTH*r))+(-1)]);
                  wire eq2_i,eq3_i;

                  assign eq2_i = sum_i == 1<<<1;
                  assign eq3_i = sum_i == 3;
                  wire next_state_i;

                  assign next_state_i = ((~cur_state_i & eq3_i) | (eq2_i & cur_state_i)) | eq3_i;
                  assign out_states[(WIDTH*r)+c] = next_state_i;
                end
          end
  endgenerate

endmodule

