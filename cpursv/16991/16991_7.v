
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[expWidth+(sigWidth+(-1)):(expWidth+(0-3))+sigWidth] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth-2];
endmodule

