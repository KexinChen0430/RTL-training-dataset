
module fpu_in2_gt_in1_3b(din1,din2,din2_neq_din1,din2_gt_din1);

  input  [2:0] din1;
  input  [2:0] din2;
  output din2_neq_din1;
  output din2_gt_din1;
  wire [2:0] din2_eq_din1;
  wire din2_neq_din1;
  wire din2_gt_din1;

  assign din2_eq_din1[2:0] = ~(((~din1 | din1) & (((~din1 & (din1 | (din2 & (~din1 | din1)))) | (~din1 | din1)) & din1)) ^ ((((~din1 & (din1 | (din2 & (~din1 | din1)))) | (~din1 | din1)) & (din2 & (~din1 | din1))) & (~din1 | din1)));
  assign din2_neq_din1 = !&din2_eq_din1;
  assign din2_gt_din1 = 
(
(din2[0] || (!din1[2] && din2[2]) || 
(!din1[1] && 
((!din1[2] && din2[2]) || (din2_eq_din1[2] && din2[1])))) && 
(!din1[0] && 
(&din2_eq_din1[2:1] || 
((din2_eq_din1[2] && din2[1] && !din1[1]) || 
(din2[2] && 
((din2_eq_din1[2] || !din1[2]) && 
(!din1[2] || (!din1[1] && din2[1])))))))) || 
                        ((din2_eq_din1[2] && din2[1] && !din1[1]) || 
(din2[2] && 
((din2_eq_din1[2] || !din1[2]) && 
(!din1[2] || (!din1[1] && din2[1])))));
endmodule

