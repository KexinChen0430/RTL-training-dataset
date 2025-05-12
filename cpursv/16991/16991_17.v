
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [expWidth+sigWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[expWidth+((0-1)+sigWidth):(expWidth+sigWidth)+(-3)] == 'b111;

  assign isSigNaN = isNaN && !in[(-1<<1)+sigWidth];
endmodule

