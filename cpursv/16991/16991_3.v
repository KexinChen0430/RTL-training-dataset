
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(sigWidth+expWidth)+(0-1):(sigWidth+expWidth)+(-3)] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth-(1+1)];
endmodule

