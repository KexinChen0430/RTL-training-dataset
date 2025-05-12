
module sameRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] a,
   input  [sigWidth+expWidth:0] b,
   output out);

  wire [3:0] 
       top4A = a[sigWidth+expWidth:(sigWidth+expWidth)+(0-3)];
  wire [3:0] 
       top4B = b[sigWidth+expWidth:(sigWidth+expWidth)+(0-3)];

  assign out = ((top4A[1+1:0] == 'b111) || (top4A[1+1:0] == 'b000)) ? ((a[(-(1+1))+sigWidth:0] == b[(-(1+1))+sigWidth:0]) && 
(top4A == top4B)) : 
               (top4A[1+1:0] == 'b110) ? (top4A == top4B) : (a == b);
endmodule

