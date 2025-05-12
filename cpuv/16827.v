module dffnr(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input C,
    input R
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(negedge C or negedge R)
        if (!R)
            Q <= 1'b0;
        else
            Q <= D;
endmodule