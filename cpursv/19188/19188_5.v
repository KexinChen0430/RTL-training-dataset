
module ror_struct  #(parameter  CTRL = 5, WIDTH = 1<<<1**CTRL)
  (input  [(0-1)+WIDTH:0] in,
   input  [(0-1)+CTRL:0] shift,
   output [WIDTH:0] out);

  wire [WIDTH:0] tmp[CTRL:0];

  assign tmp[CTRL] = {in[31],in};
  assign out = tmp[0];
  genvar i;
  
  generate
      for (i = 0; i < CTRL; i = i+1)
          begin : mux
            assign tmp[i] = shift[i] ? {tmp[i+1][(0-1)+(1<<<1**i)],tmp[i+1][(0-1)+(1<<<1**i):0],tmp[i+1][(0-1)+WIDTH:1<<<1**i]} : tmp[i+1];
          end
  endgenerate

endmodule

