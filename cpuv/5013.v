module cycloneii_b17mux21 (MO, A, B, S);
   input [16:0] A;
   input [16:0] B;
   input 	S;
   output [16:0] MO;
   assign MO = (S == 1) ? B : A;
endmodule