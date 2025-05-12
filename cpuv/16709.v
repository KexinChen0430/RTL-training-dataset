module func2(A, out);
    input [`WIDTH+2:0] A;
    output [`WIDTH+2:0] out;
    assign out = {A[`WIDTH:0], 2'd0};
endmodule