
module isSigNaNRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] in,
   output isSigNaN);

  wire 
       isNaN = in[(sigWidth+expWidth)-1:sigWidth+((0-3)+expWidth)] == 'b111;

  assign isSigNaN = isNaN && !in[sigWidth+(0-2)];
endmodule

