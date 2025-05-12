module toplevel(
    input              clk50, 
    input              cpu_rst_n, 
    output reg [ 7:0]  f_led, 
    output      [13:0] ram_a, 
    output      [ 1:0] ram_ba, 
    output             ram_cas_n, 
    output             ram_ck_n, 
    output             ram_ck_p, 
    output             ram_cke, 
    output             ram_cs_n, 
    inout      [15:0]  ram_d, 
    output             ram_ldm, 
    output             ram_ldqs, 
    output             ram_ras_n, 
    output             ram_udm, 
    output             ram_udqs, 
    output             ram_ws_n 
);
endmodule