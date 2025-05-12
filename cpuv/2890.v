module abc9_test016(input a, output b); 
assign b = ~a; 
(* keep *) reg c; 
always @* c <= ~a; 
endmodule 