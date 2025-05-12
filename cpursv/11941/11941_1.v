
module handler_params_decoder(input  [5:0] irqVector,
                              input  [17:1] irqOffset,
                              output [7:0] irqNumber);

  assign irqNumber = {2'b0,irqVector};
endmodule

