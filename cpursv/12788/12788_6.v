
module altgxb_xgm_reset_block(txdigitalreset,rxdigitalreset,rxanalogreset,pllreset,
                              pllenable,txdigitalresetout,rxdigitalresetout,
                              txanalogresetout,rxanalogresetout,pllresetout);

  input  [3:0] txdigitalreset;
  input  [3:0] rxdigitalreset;
  input  [3:0] rxanalogreset;
  input  pllreset;
  input  pllenable;
  output [3:0] txdigitalresetout;
  output [3:0] rxdigitalresetout;
  output [3:0] txanalogresetout;
  output [3:0] rxanalogresetout;
  output pllresetout;
  wire HARD_RESET;

  assign HARD_RESET = pllreset || !pllenable;
  assign rxanalogresetout = {rxanalogreset[3] | HARD_RESET,rxanalogreset[2] | HARD_RESET,HARD_RESET | rxanalogreset[1],rxanalogreset[0] | HARD_RESET};
  assign txanalogresetout = {HARD_RESET,HARD_RESET,HARD_RESET,HARD_RESET};
  assign pllresetout = (txanalogresetout[0] & (txanalogresetout[3] & rxanalogresetout[0])) & ((rxanalogresetout[2] & txanalogresetout[1]) & ((txanalogresetout[2] & rxanalogresetout[3]) & rxanalogresetout[1]));
  assign rxdigitalresetout = {rxdigitalreset[3] | HARD_RESET,HARD_RESET | rxdigitalreset[2],rxdigitalreset[1] | HARD_RESET,HARD_RESET | rxdigitalreset[0]};
  assign txdigitalresetout = {txdigitalreset[3] | HARD_RESET,txdigitalreset[2] | HARD_RESET,HARD_RESET | txdigitalreset[1],HARD_RESET | txdigitalreset[0]};
endmodule

