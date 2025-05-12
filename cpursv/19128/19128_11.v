
module asr_struct  #(parameter  CTRL = 5, WIDTH = 2**CTRL)
  (input  [(-1)+WIDTH:0] in,
   input  [CTRL+(-1):0] shift,
   output [WIDTH:0] out);

  wire  sign = in[(-1)+WIDTH];
  wire [WIDTH:0] tmp[CTRL:0];

  assign tmp[CTRL] = {in[0],in};
  assign out = tmp[0];
  genvar i;
  
  generate
      for (i = 0; i < CTRL; i = 1+i)
          begin : mux
            assign tmp[i] = shift[i] ? {tmp[1+i][(2**i)+(-1)],{2**i{sign}},tmp[1+i][(-1)+WIDTH:2**i]} : tmp[1+i];
          end
  endgenerate

endmodule

