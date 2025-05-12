module abc9_test015(
    input a,  
    output b, 
    input c   
);
assign b = ~a;
(* keep *) wire d;
assign d = ~c;
endmodule