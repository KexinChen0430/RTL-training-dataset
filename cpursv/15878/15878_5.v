
module sameRecFN  #(parameter  expWidth = 3, sigWidth = 3)
  (input  [sigWidth+expWidth:0] a,
   input  [sigWidth+expWidth:0] b,
   output out);

  wire [3:0] 
       top4A = a[sigWidth+expWidth:(0-3)+(sigWidth+expWidth)];
  wire [3:0] 
       top4B = b[sigWidth+expWidth:(0-3)+(sigWidth+expWidth)];

  assign out = ((top4A[2:0] == 'b111) || (top4A[2:0] == 'b000)) ? ((a[(0-2)+sigWidth:0] == b[(0-2)+sigWidth:0]) && 
(top4A == top4B)) : 
               (top4A[2:0] == 'b110) ? (top4A == top4B) : (a == b);
endmodule

