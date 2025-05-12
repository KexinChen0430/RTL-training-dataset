module inv(
    input [7:0] a,       
    output wire [7:0] z  
);
assign z = ~a;
endmodule 