
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [expWidth+sigWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(sigWidth+(0-1))+expWidth:(sigWidth+(-3))+expWidth] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth-(1+1)];
endmodule

