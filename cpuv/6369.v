module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(GPIO_I, GPIO_O, GPIO_T, SDIO0_WP, TTC0_WAVE0_OUT, 
  PS_SRSTB, PS_CLK, PS_PORB) 
;
  input [63:0]GPIO_I; 
  output [63:0]GPIO_O; 
  output [63:0]GPIO_T; 
  input SDIO0_WP; 
  output TTC0_WAVE0_OUT; 
  output TTC0_WAVE1_OUT; 
  output TTC0_WAVE2_OUT; 
  output [1:0]USB0_PORT_INDCTL; 
  output USB0_VBUS_PWRSELECT; 
  input USB0_VBUS_PWRFAULT; 
  inout PS_PORB; 
endmodule 