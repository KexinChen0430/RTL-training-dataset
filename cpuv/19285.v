module swap (
    inout wire [31:0] a, 
    inout wire [31:0] b  
);
alias {a[7:0],a[15:8],a[23:16],a[31:24]} = b;
endmodule 