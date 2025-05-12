module selNextPPV(
    pre_nppv,
    outdir,
    nppv
    );
    input [`NUM_PORT*4-1:0] pre_nppv;
    input [1:0] outdir;
    output [`NUM_PORT-1:0] nppv;
    wire [`NUM_PORT-1:0] w_nppv [0:3];
    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin : split_nppv
            assign w_nppv[i] = pre_nppv[i*`NUM_PORT +: `NUM_PORT];
        end
    endgenerate
    assign nppv = outdir == 0 ? w_nppv[0] :
                  outdir == 1 ? w_nppv[1] :
                  outdir == 2 ? w_nppv[2] :
                  outdir == 3 ? w_nppv[3] :
                  `NUM_PORT'h0;
endmodule