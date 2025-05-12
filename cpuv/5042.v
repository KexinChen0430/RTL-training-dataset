module cycloneii_bmux21 (MO, A, B, S);
   input [15:0] A;
   input [15:0] B;
   input 	S;
   output [15:0] MO;
   assign MO = (S == 1) ? B : A;
endmodule