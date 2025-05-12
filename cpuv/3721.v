module rcMC(
    dstList,
    preferPortVector
    );
    input [`DST_LIST_WIDTH-1:0] dstList;
    output [`NUM_PORT-1:0] preferPortVector;
    assign preferPortVector [0] = |(dstList & `N_MASK);
    assign preferPortVector [1] = |(dstList & `E_MASK);
    assign preferPortVector [2] = |(dstList & `S_MASK);
    assign preferPortVector [3] = |(dstList & `W_MASK);
    assign preferPortVector [4] = |(dstList & `L_MASK);
endmodule