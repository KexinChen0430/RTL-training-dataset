
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(sigWidth+expWidth)-1:(-3)+(sigWidth+expWidth)] == 'b111;

  assign isSigNaN = !in[sigWidth-1<<1] && isNaN;
endmodule

