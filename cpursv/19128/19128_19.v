
module asr_struct  #(parameter  CTRL = 5, WIDTH = 1<<<1**CTRL)
  (input  [WIDTH+(0-1):0] in,
   input  [CTRL-1:0] shift,
   output [WIDTH:0] out);

  wire  sign = in[WIDTH+(0-1)];
  wire [WIDTH:0] tmp[CTRL:0];

  assign tmp[CTRL] = {in[0],in};
  assign out = tmp[0];
  genvar i;
  
  generate
      for (i = 0; i < CTRL; i = i+1)
          begin : mux
            assign tmp[i] = shift[i] ? {tmp[i+1][(1<<<1**i)-1],{1<<<1**i{sign}},tmp[i+1][WIDTH+(0-1):1<<<1**i]} : tmp[i+1];
          end
  endgenerate

endmodule

