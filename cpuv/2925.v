module abc9_test018(
    input a,  
    output b, 
    output c  
);
assign b = ~a;
(* keep *) wire [1:0] d;
assign c = &d;
endmodule 