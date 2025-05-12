module cpx_buf_pdr_even(
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
   input arbcp0_cpxdp_grant_bufp3_ca,     
   input arbcp0_cpxdp_q0_hold_bufp3_ca_l, 
   input arbcp0_cpxdp_qsel0_bufp3_ca,     
   input arbcp0_cpxdp_qsel1_bufp3_ca_l,   
   input arbcp0_cpxdp_shift_bufp3_cx,     
   assign arbcp0_cpxdp_grant_ca = arbcp0_cpxdp_grant_bufp3_ca;
   assign arbcp0_cpxdp_q0_hold_ca_l = arbcp0_cpxdp_q0_hold_bufp3_ca_l;
   assign arbcp0_cpxdp_qsel0_ca = arbcp0_cpxdp_qsel0_bufp3_ca;
   assign arbcp0_cpxdp_qsel1_ca_l = arbcp0_cpxdp_qsel1_bufp3_ca_l;
   assign arbcp0_cpxdp_shift_cx = arbcp0_cpxdp_shift_bufp3_cx;
endmodule