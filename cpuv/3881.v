module cpx_buf_pm_even(
   output arbcp0_cpxdp_grant_ca,
   output arbcp0_cpxdp_q0_hold_ca_l,
   output arbcp0_cpxdp_qsel0_ca,
   output arbcp0_cpxdp_qsel1_ca_l,
   output arbcp0_cpxdp_shift_cx,
   output arbcp2_cpxdp_grant_ca,
   output arbcp2_cpxdp_q0_hold_ca_l,
   output arbcp2_cpxdp_qsel0_ca,
   output arbcp2_cpxdp_qsel1_ca_l,
   output arbcp2_cpxdp_shift_cx,
   output arbcp4_cpxdp_grant_ca,
   output arbcp4_cpxdp_q0_hold_ca_l,
   output arbcp4_cpxdp_qsel0_ca,
   output arbcp4_cpxdp_qsel1_ca_l,
   output arbcp4_cpxdp_shift_cx,
   output arbcp6_cpxdp_grant_ca,
   output arbcp6_cpxdp_q0_hold_ca_l,
   output arbcp6_cpxdp_qsel0_ca,
   output arbcp6_cpxdp_qsel1_ca_l,
   output arbcp6_cpxdp_shift_cx,
   input arbcp0_cpxdp_grant_arbbf_ca_l,
   input arbcp0_cpxdp_q0_hold_arbbf_ca,
   input arbcp0_cpxdp_qsel0_arbbf_ca_l,
   input arbcp0_cpxdp_qsel1_arbbf_ca,
   input arbcp0_cpxdp_shift_arbbf_cx_l,
   input arbcp2_cpxdp_grant_arbbf_ca_l,
   input arbcp2_cpxdp_q0_hold_arbbf_ca,
   input arbcp2_cpxdp_qsel0_arbbf_ca_l,
   input arbcp2_cpxdp_qsel1_arbbf_ca,
   input arbcp2_cpxdp_shift_arbbf_cx_l,
   input arbcp4_cpxdp_grant_arbbf_ca_l,
   input arbcp4_cpxdp_q0_hold_arbbf_ca,
   input arbcp4_cpxdp_qsel0_arbbf_ca_l,
   input arbcp4_cpxdp_qsel1_arbbf_ca,
   input arbcp4_cpxdp_shift_arbbf_cx_l,
   input arbcp6_cpxdp_grant_arbbf_ca_l,
   input arbcp6_cpxdp_q0_hold_arbbf_ca,
   input arbcp6_cpxdp_qsel0_arbbf_ca_l,
   input arbcp6_cpxdp_qsel1_arbbf_ca,
   input arbcp6_cpxdp_shift_arbbf_cx_l
);
assign arbcp0_cpxdp_grant_ca       = ~arbcp0_cpxdp_grant_arbbf_ca_l;
assign arbcp0_cpxdp_q0_hold_ca_l   = ~arbcp0_cpxdp_q0_hold_arbbf_ca;
assign arbcp0_cpxdp_qsel0_ca       = ~arbcp0_cpxdp_qsel0_arbbf_ca_l;
assign arbcp0_cpxdp_qsel1_ca_l     = ~arbcp0_cpxdp_qsel1_arbbf_ca;
assign arbcp0_cpxdp_shift_cx       = ~arbcp0_cpxdp_shift_arbbf_cx_l;
assign arbcp2_cpxdp_grant_ca       = ~arbcp2_cpxdp_grant_arbbf_ca_l;
assign arbcp2_cpxdp_q0_hold_ca_l   = ~arbcp2_cpxdp_q0_hold_arbbf_ca;
assign arbcp2_cpxdp_qsel0_ca       = ~arbcp2_cpxdp_qsel0_arbbf_ca_l;
assign arbcp2_cpxdp_qsel1_ca_l     = ~arbcp2_cpxdp_qsel1_arbbf_ca;
assign arbcp2_cpxdp_shift_cx       = ~arbcp2_cpxdp_shift_arbbf_cx_l;
assign arbcp4_cpxdp_grant_ca       = ~arbcp4_cpxdp_grant_arbbf_ca_l;
assign arbcp4_cpxdp_q0_hold_ca_l   = ~arbcp4_cpxdp_q0_hold_arbbf_ca;
assign arbcp4_cpxdp_qsel0_ca       = ~arbcp4_cpxdp_qsel0_arbbf_ca_l;
assign arbcp4_cpxdp_qsel1_ca_l     = ~arbcp4_cpxdp_qsel1_arbbf_ca;
assign arbcp4_cpxdp_shift_cx       = ~arbcp4_cpxdp_shift_arbbf_cx_l;
assign arbcp6_cpxdp_grant_ca       = ~arbcp6_cpxdp_grant_arbbf_ca_l;
assign arbcp6_cpxdp_q0_hold_ca_l   = ~arbcp6_cpxdp_q0_hold_arbbf_ca;
assign arbcp6_cpxdp_qsel0_ca       = ~arbcp6_cpxdp_qsel0_arbbf_ca_l;
assign arbcp6_cpxdp_qsel1_ca_l     = ~arbcp6_cpxdp_qsel1_arbbf_ca;
assign arbcp6_cpxdp_shift_cx       = ~arbcp6_cpxdp_shift_arbbf_cx_l;
endmodule 