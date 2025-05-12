module seqPortAlloc(
    numFlit_in,             
    availPortVector_in,     
    ppv,                    
    allocatedPortVector,    
    availPortVector_out,    
    numFlit_out             
    );
    input [`PC_INDEX_WIDTH-1:0] numFlit_in; 
    input [`NUM_PORT-2:0] availPortVector_in, ppv; 
    output [`NUM_PORT-2:0] allocatedPortVector, availPortVector_out; 
    output [`PC_INDEX_WIDTH-1:0] numFlit_out; 
    wire [`PC_INDEX_WIDTH-1:0] numFlit [`NUM_PORT-1:0];
    wire [`NUM_PORT-2:0] allocatedPortVector_st1, availPortVector_out_st1;
    wire [`NUM_PORT-2:0] allocatedPortVector_st2, availPortVector_out_st2;
    assign numFlit[0] = numFlit_in;
    genvar i;
    generate
    for (i=0; i<`NUM_PORT-1; i=i+1) begin : productiveAlloc
        assign allocatedPortVector_st1[i] = ppv[i] && availPortVector_in[i] && (numFlit[i] <= `NUM_PORT-1);
        assign numFlit[i+1] = numFlit[i] + allocatedPortVector_st1[i];
        assign availPortVector_out_st1[i] = availPortVector_in[i] && ~allocatedPortVector_st1[i];
    end
    endgenerate
    assign allocatedPortVector_st2[0] = availPortVector_out_st1[0];
    assign allocatedPortVector_st2[1] = availPortVector_out_st1[1] && ~availPortVector_out_st1[0];
    assign allocatedPortVector_st2[2] = availPortVector_out_st1[2] && ~availPortVector_out_st1[1] && ~availPortVector_out_st1[0];
    assign allocatedPortVector_st2[3] = availPortVector_out_st1[3] && ~availPortVector_out_st1[2] && ~availPortVector_out_st1[1] && ~availPortVector_out_st1[0];
    assign availPortVector_out_st2 [0] = 1'b0;
    assign availPortVector_out_st2 [1] = availPortVector_out_st1[0] && availPortVector_out_st1[1];
    assign availPortVector_out_st2 [2] = |availPortVector_out_st1[1:0] && availPortVector_out_st1[2];
    assign availPortVector_out_st2 [3] = |availPortVector_out_st1[2:0] && availPortVector_out_st1[3];
    wire get_port_st1;
    assign get_port_st1 = |allocatedPortVector_st1;
    assign allocatedPortVector = (~|ppv || get_port_st1) ? allocatedPortVector_st1 : allocatedPortVector_st2;
    assign availPortVector_out = (~|ppv || get_port_st1) ? availPortVector_out_st1 : availPortVector_out_st2;
    assign numFlit_out = (~|ppv || get_port_st1) ? numFlit[`NUM_PORT-1] : numFlit[`NUM_PORT-1] + 1'b1;
endmodule