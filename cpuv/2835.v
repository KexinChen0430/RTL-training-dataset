module abc9_test017(input a, output b); 
assign b = ~a; 
(* keep *) reg c; 
always @* c = b; 
endmodule 