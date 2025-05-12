
module ror_struct  #(parameter  CTRL = 5, WIDTH = 1<<1**CTRL)
  (input  [WIDTH-1:0] in,
   input  [CTRL-1:0] shift,
   output [WIDTH:0] out);

  wire [WIDTH:0] tmp[CTRL:0];

  assign tmp[CTRL] = {in[31],in};
  assign out = tmp[0];
  genvar i;
  
  generate
      for (i = 0; i < CTRL; i = i+1)
          begin : mux
            assign tmp[i] = shift[i] ? {tmp[i+1][(1<<1**i)-1],tmp[i+1][(1<<1**i)-1:0],tmp[i+1][WIDTH-1:1<<1**i]} : tmp[i+1];
          end
  endgenerate

endmodule

