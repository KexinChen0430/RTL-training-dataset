
module sameRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [expWidth+sigWidth:0] a,
   input  [expWidth+sigWidth:0] b,
   output out);

  wire [3:0] 
       top4A = a[expWidth+sigWidth:sigWidth+((0-3)+expWidth)];
  wire [3:0] 
       top4B = b[expWidth+sigWidth:sigWidth+((0-3)+expWidth)];

  assign out = ((top4A[1+1:0] == 'b111) || (top4A[1+1:0] == 'b000)) ? (
(a[sigWidth+(0-(1+1)):0] == b[sigWidth+(0-(1+1)):0]) && (top4A == top4B)) : 
               (top4A[1+1:0] == 'b110) ? (top4A == top4B) : (a == b);
endmodule

