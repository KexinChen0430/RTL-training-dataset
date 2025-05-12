module \$_OAI3_ (A, B, C, Y); 
input A, B, C;                 
output Y;                      
assign Y = ~((A | B) & C);     
endmodule                      