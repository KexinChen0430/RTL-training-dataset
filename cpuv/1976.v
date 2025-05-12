module system_zybo_hdmi_0_0(clk_125, clk_25, hsync, vsync, active, rgb, tmds,
  tmdsb, hdmi_cec, hdmi_hpd, hdmi_out_en)
;
  input clk_125; 
  input clk_25;  
  input hsync;   
  input vsync;   
  input active;  
  input [23:0]rgb; 
  output [3:0]tmds;  
  output [3:0]tmdsb; 
  input hdmi_cec;    
  input hdmi_hpd;    
  output hdmi_out_en; 
endmodule