
module x;

  
  always @(arb_select_f or octet_idx)
      begin
        octet_flag[0] = |arb_select_f[7:0];
        octet_flag[1] = |arb_select_f[15:8];
        octet_flag[2] = |arb_select_f[23:16];
        octet_flag[3] = |arb_select_f[31:24];
        octet_flag[4] = |arb_select_f[39:32];
        octet_flag[5] = |arb_select_f[47:40];
        octet_flag[6] = |arb_select_f[55:48];
        octet_flag[7] = |arb_select_f[63:56];
        octet_available = |octet_flag;
        shifted8_64 = barrel_shifter(octet_flag,octet_idx[5:3]);
      end
endmodule

