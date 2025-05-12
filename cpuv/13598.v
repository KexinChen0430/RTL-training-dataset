module altpcie_reconfig_4sgx_mux_c6a
(
    data,
    result,
    sel
) ;
    input [7:0] data; 
    output [0:0] result; 
    input [2:0] sel; 
    `ifndef ALTERA_RESERVED_QIS
    `endif
    tri0 [7:0] data; 
    tri0 [2:0] sel; 
    `ifndef ALTERA_RESERVED_QIS
    `endif
    wire wire_l1_w0_n0_mux_dataout;
    wire wire_l1_w0_n1_mux_dataout;
    wire wire_l1_w0_n2_mux_dataout;
    wire wire_l1_w0_n3_mux_dataout;
    wire wire_l2_w0_n0_mux_dataout;
    wire wire_l2_w0_n1_mux_dataout;
    wire wire_l3_w0_n0_mux_dataout;
    wire [13:0] data_wire;
    wire [0:0] result_wire_ext;
    wire [8:0] sel_wire;
    assign wire_l1_w0_n0_mux_dataout = (sel_wire[0] === 1'b1) ? data_wire[1] : data_wire[0];
    assign wire_l1_w0_n1_mux_dataout = (sel_wire[0] === 1'b1) ? data_wire[3] : data_wire[2];
    assign wire_l1_w0_n2_mux_dataout = (sel_wire[0] === 1'b1) ? data_wire[5] : data_wire[4];
    assign wire_l1_w0_n3_mux_dataout = (sel_wire[0] === 1'b1) ? data_wire[7] : data_wire[6];
    assign wire_l2_w0_n0_mux_dataout = (sel_wire[4] === 1'b1) ? data_wire[9] : data_wire[8];
    assign wire_l2_w0_n1_mux_dataout = (sel_wire[4] === 1'b1) ? data_wire[11] : data_wire[10];
    assign wire_l3_w0_n0_mux_dataout = (sel_wire[8] === 1'b1) ? data_wire[13] : data_wire[12];
    assign
        data_wire = {wire_l2_w0_n1_mux_dataout, wire_l2_w0_n0_mux_dataout, wire_l1_w0_n3_mux_dataout, wire_l1_w0_n2_mux_dataout, wire_l1_w0_n1_mux_dataout, wire_l1_w0_n0_mux_dataout, data},
        result = result_wire_ext,
        result_wire_ext = {wire_l3_w0_n0_mux_dataout},
        sel_wire = {sel[2], {3{1'b0}}, sel[1], {3{1'b0}}, sel[0]};
endmodule