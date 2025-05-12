
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(-1)+(sigWidth+expWidth):sigWidth+((-3)+expWidth)] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth+(0-1<<1)];
endmodule

