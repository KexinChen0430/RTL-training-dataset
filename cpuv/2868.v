module abc9_test026(
    output [3:0] o, 
    output [3:0] p  
);
assign o = { 1'b1, 1'bx };
assign p = { 1'b1, 1'bx, 1'b0 };
endmodule