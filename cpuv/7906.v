module nios_system_nios2_qsys_0_nios2_oci_pib (
    input   [ 35: 0] tw,
    output  [ 35: 0] tr_data
);
wire    [ 35: 0] tr_data;
assign tr_data = 0 ? tw : 0;
endmodule