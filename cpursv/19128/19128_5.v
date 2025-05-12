
module asr_struct  #(parameter  CTRL = 5, WIDTH = (1+1)**CTRL)
  (input  [(0-1)+WIDTH:0] in,
   input  [(0-1)+CTRL:0] shift,
   output [WIDTH:0] out);

  wire  sign = in[(0-1)+WIDTH];
  wire [WIDTH:0] tmp[CTRL:0];

  assign tmp[CTRL] = {in[0],in};
  assign out = tmp[0];
  genvar i;
  
  generate
      for (i = 0; i < CTRL; i = 1+i)
          begin : mux
            assign tmp[i] = shift[i] ? {tmp[1+i][(0-1)+((1+1)**i)],{(1+1)**i{sign}},tmp[1+i][(0-1)+WIDTH:(1+1)**i]} : tmp[1+i];
          end
  endgenerate

endmodule

