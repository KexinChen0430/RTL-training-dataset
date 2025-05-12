
module limbus_nios2_qsys_0_nios2_oci_xbrk(D_valid,E_valid,F_pc,clk,reset_n,trigger_state_0,
                                          trigger_state_1,xbrk_ctrl0,xbrk_ctrl1,xbrk_ctrl2,xbrk_ctrl3,
                                          xbrk_break,xbrk_goto0,xbrk_goto1,xbrk_traceoff,xbrk_traceon,
                                          xbrk_trigout);

  output xbrk_break;
  output xbrk_goto0;
  output xbrk_goto1;
  output xbrk_traceoff;
  output xbrk_traceon;
  output xbrk_trigout;
  input  D_valid;
  input  E_valid;
  input  [26:0] F_pc;
  input  clk;
  input  reset_n;
  input  trigger_state_0;
  input  trigger_state_1;
  input  [7:0] xbrk_ctrl0;
  input  [7:0] xbrk_ctrl1;
  input  [7:0] xbrk_ctrl2;
  input  [7:0] xbrk_ctrl3;
  wire D_cpu_addr_en;
  wire E_cpu_addr_en;
  reg  E_xbrk_goto0;
  reg  E_xbrk_goto1;
  reg  E_xbrk_traceoff;
  reg  E_xbrk_traceon;
  reg  E_xbrk_trigout;
  wire [28:0] cpu_i_address;
  wire xbrk0_armed;
  wire xbrk0_break_hit;
  wire xbrk0_goto0_hit;
  wire xbrk0_goto1_hit;
  wire xbrk0_toff_hit;
  wire xbrk0_ton_hit;
  wire xbrk0_tout_hit;
  wire xbrk1_armed;
  wire xbrk1_break_hit;
  wire xbrk1_goto0_hit;
  wire xbrk1_goto1_hit;
  wire xbrk1_toff_hit;
  wire xbrk1_ton_hit;
  wire xbrk1_tout_hit;
  wire xbrk2_armed;
  wire xbrk2_break_hit;
  wire xbrk2_goto0_hit;
  wire xbrk2_goto1_hit;
  wire xbrk2_toff_hit;
  wire xbrk2_ton_hit;
  wire xbrk2_tout_hit;
  wire xbrk3_armed;
  wire xbrk3_break_hit;
  wire xbrk3_goto0_hit;
  wire xbrk3_goto1_hit;
  wire xbrk3_toff_hit;
  wire xbrk3_ton_hit;
  wire xbrk3_tout_hit;
  reg  xbrk_break;
  wire xbrk_break_hit;
  wire xbrk_goto0;
  wire xbrk_goto0_hit;
  wire xbrk_goto1;
  wire xbrk_goto1_hit;
  wire xbrk_toff_hit;
  wire xbrk_ton_hit;
  wire xbrk_tout_hit;
  wire xbrk_traceoff;
  wire xbrk_traceon;
  wire xbrk_trigout;

  assign cpu_i_address = {F_pc,2'b00};
  assign D_cpu_addr_en = D_valid;
  assign E_cpu_addr_en = E_valid;
  assign xbrk0_break_hit = 0;
  assign xbrk0_ton_hit = 0;
  assign xbrk0_toff_hit = 0;
  assign xbrk0_tout_hit = 0;
  assign xbrk0_goto0_hit = 0;
  assign xbrk0_goto1_hit = 0;
  assign xbrk1_break_hit = 0;
  assign xbrk1_ton_hit = 0;
  assign xbrk1_toff_hit = 0;
  assign xbrk1_tout_hit = 0;
  assign xbrk1_goto0_hit = 0;
  assign xbrk1_goto1_hit = 0;
  assign xbrk2_break_hit = 0;
  assign xbrk2_ton_hit = 0;
  assign xbrk2_toff_hit = 0;
  assign xbrk2_tout_hit = 0;
  assign xbrk2_goto0_hit = 0;
  assign xbrk2_goto1_hit = 0;
  assign xbrk3_break_hit = 0;
  assign xbrk3_ton_hit = 0;
  assign xbrk3_toff_hit = 0;
  assign xbrk3_tout_hit = 0;
  assign xbrk3_goto0_hit = 0;
  assign xbrk3_goto1_hit = 0;
  assign xbrk_break_hit = xbrk0_break_hit | (xbrk2_break_hit | (xbrk3_break_hit | xbrk1_break_hit));
  assign xbrk_ton_hit = (xbrk3_ton_hit | xbrk1_ton_hit) | (xbrk2_ton_hit | xbrk0_ton_hit);
  assign xbrk_toff_hit = xbrk3_toff_hit | (xbrk2_toff_hit | (xbrk1_toff_hit | xbrk0_toff_hit));
  assign xbrk_tout_hit = xbrk2_tout_hit | ((xbrk1_tout_hit | xbrk3_tout_hit) | xbrk0_tout_hit);
  assign xbrk_goto0_hit = ((xbrk3_goto0_hit | xbrk0_goto0_hit) | xbrk1_goto0_hit) | xbrk2_goto0_hit;
  assign xbrk_goto1_hit = (xbrk0_goto1_hit | xbrk2_goto1_hit) | (xbrk3_goto1_hit | xbrk1_goto1_hit);
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) xbrk_break <= 0;
        else if (E_cpu_addr_en) xbrk_break <= xbrk_break_hit;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) E_xbrk_traceon <= 0;
        else if (E_cpu_addr_en) E_xbrk_traceon <= xbrk_ton_hit;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) E_xbrk_traceoff <= 0;
        else if (E_cpu_addr_en) E_xbrk_traceoff <= xbrk_toff_hit;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) E_xbrk_trigout <= 0;
        else if (E_cpu_addr_en) E_xbrk_trigout <= xbrk_tout_hit;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) E_xbrk_goto0 <= 0;
        else if (E_cpu_addr_en) E_xbrk_goto0 <= xbrk_goto0_hit;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) E_xbrk_goto1 <= 0;
        else if (E_cpu_addr_en) E_xbrk_goto1 <= xbrk_goto1_hit;
          
      end
  assign xbrk_traceon = 1'b0;
  assign xbrk_traceoff = 1'b0;
  assign xbrk_trigout = 1'b0;
  assign xbrk_goto0 = 1'b0;
  assign xbrk_goto1 = 1'b0;
  assign xbrk0_armed = (trigger_state_0 & xbrk_ctrl0[4]) || 
                       (xbrk_ctrl0[5] & trigger_state_1);
  assign xbrk1_armed = (trigger_state_1 & xbrk_ctrl1[5]) || 
                       (trigger_state_0 & xbrk_ctrl1[4]);
  assign xbrk2_armed = (xbrk_ctrl2[4] & trigger_state_0) || 
                       (trigger_state_1 & xbrk_ctrl2[5]);
  assign xbrk3_armed = (trigger_state_1 & xbrk_ctrl3[5]) || 
                       (xbrk_ctrl3[4] & trigger_state_0);
endmodule

