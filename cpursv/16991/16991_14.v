
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [expWidth+sigWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(expWidth+sigWidth)-1:sigWidth+(expWidth+(-3))] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth-(1+1)];
endmodule

