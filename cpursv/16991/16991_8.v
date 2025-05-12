
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [expWidth+sigWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(0-1)+(expWidth+sigWidth):(-3)+(expWidth+sigWidth)] == 'b111;

  assign isSigNaN = !in[sigWidth-(1+1)] && isNaN;
endmodule

