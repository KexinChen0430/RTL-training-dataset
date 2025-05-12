module \$_MUX_ (A, B, S, Y);
input A, B, S;
output Y;
assign Y = S ? B : A;
endmodule