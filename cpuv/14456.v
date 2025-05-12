module \$_MUX4_ (A, B, C, D, S, T, Y);
input A, B, C, D;
input S, T;
output Y;
assign Y = T ? (S ? D : C) : 
               (S ? B : A);  
endmodule