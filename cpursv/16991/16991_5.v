
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [expWidth+sigWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(-1)+(expWidth+sigWidth):(-3)+(expWidth+sigWidth)] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth-2];
endmodule

