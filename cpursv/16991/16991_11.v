
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[expWidth+(sigWidth+(0-1)):sigWidth+((-3)+expWidth)] == 'b111;

  assign isSigNaN = !in[(-2)+sigWidth] && isNaN;
endmodule

