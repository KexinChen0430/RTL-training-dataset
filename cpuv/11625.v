module sysctl_regs
   #(
     parameter g_fml_depth = 26, 
     parameter g_default_pll_mul = 1, 
     parameter g_default_pll_sys_div = 2 
     )
  (
   input clk_sys_i, 
   input rst_n_i, 
   input [31:0] wb_adr_i, 
   input [31:0] wb_dat_i, 
   output reg [31:0] wb_dat_o, 
   input [3:0] wb_sel_i, 
   input wb_cyc_i, 
   input wb_stb_i, 
   input wb_we_i, 
   output wb_ack_o, 
   output wb_stall_o, 
   output r_fb_enable_o, 
   output r_fb_pix32_o, 
   output [g_fml_depth-1:0] r_fb_addr_o, 
   output [g_fml_depth-1:0] r_fb_size_o, 
   output [7:0] r_mixer_ctl_o, 
   input [7:0] r_mixer_ctl_i, 
   output reg [7:0] r_edid_addr_o, 
   output reg [7:0] r_edid_data_o, 
   output reg r_edid_wr_o, 
   output reg [7:0] r_pwm_ctl_o, 
   output reg [31:0] r_pll_ctl0_o, 
   output reg [31:0] r_pll_ctl1_o, 
   input [31:0] r_pll_status_i, 
   output [31:0] r_gpio_o, 
   input [31:0] r_gpio_i 
   );
   reg [7:0] r_mixer_ctl; 
   reg r_fb_pix32, r_fb_enable; 
   reg [g_fml_depth-1:0] r_fb_addr; 
   reg [g_fml_depth-1:0] r_fb_size; 
   reg [31:0] r_gpio; 
   reg [31:0] r_pll_freq = (25000000 * g_default_pll_mul / g_default_pll_sys_div); 
   always@(posedge clk_sys_i)
     if(!rst_n_i) 
       begin
          r_fb_enable <= 0;
          r_fb_pix32 <= 0;
          r_mixer_ctl <= 0;
          r_gpio <= 0;
          r_pll_ctl0_o <= 0;
          r_pll_ctl1_o <= 0;
          r_edid_wr_o <= 0;
       end else begin 
          r_edid_wr_o <= 0;
          if(wb_stb_i & wb_cyc_i) begin
             if(wb_we_i)
               case (wb_adr_i[5:0])
                 `REG_CTL: {r_fb_pix32,r_fb_enable} <= wb_dat_i[3:0];
                 `REG_MIXCTL: r_mixer_ctl <= wb_dat_i[7:0];
                 `REG_FB_ADDR: r_fb_addr <= wb_dat_i;
                 `REG_FB_SIZE: r_fb_size <= wb_dat_i;
                 `REG_EDID_CTL:  begin
                    r_edid_addr_o <= wb_dat_i[7:0];
                    r_edid_data_o <= wb_dat_i[15:8];
                    r_edid_wr_o <= 1;
                 end
                 `REG_PLL_CONFIG0:
                    r_pll_ctl0_o <= wb_dat_i[31:0];
                 `REG_PLL_CONFIG1:
                    r_pll_ctl1_o <= wb_dat_i[31:0];
                 `REG_PWM_CONFIG:
                    r_pwm_ctl_o <= wb_dat_i[7:0];
                 `REG_GPIO_OUT:
                    r_gpio <= wb_dat_i[31:0];
                 `REG_PLL_FREQ:
                    r_pll_freq <= wb_dat_i[31:0];
               endcase 
             else 
               case (wb_adr_i[5:0])
                 `REG_CTL: wb_dat_o[3:0] <= {r_fb_pix32,r_fb_enable};
                 `REG_MIXCTL: wb_dat_o[15:0] <= { r_mixer_ctl_i, r_mixer_ctl };
                 `REG_FB_ADDR: wb_dat_o <= r_fb_addr;
                 `REG_FB_SIZE: wb_dat_o <= r_fb_size;
                 `REG_PLL_STATUS: wb_dat_o <= r_pll_status_i;
                 `REG_GPIO_OUT: wb_dat_o <= r_gpio;
                 `REG_GPIO_IN: wb_dat_o <= r_gpio_i;
                 `REG_PLL_FREQ : wb_dat_o <= r_pll_freq;
               endcase 
          end 
       end 
   reg [2:0] cyc_dly;
   always@(posedge clk_sys_i)
     if(!rst_n_i) 
       cyc_dly <= 0; 
     else
       cyc_dly <= { cyc_dly[1:0], wb_cyc_i & wb_stb_i }; 
   assign wb_stall_o = ~ (~cyc_dly[1] & cyc_dly[0]);
   assign wb_ack_o = (cyc_dly==3);
   assign r_mixer_ctl_o = r_mixer_ctl;
   assign r_gpio_o = r_gpio;
   assign r_fb_enable_o = r_fb_enable;
   assign r_fb_pix32_o = r_fb_pix32;
   assign r_fb_addr_o = r_fb_addr;
   assign r_fb_size_o = r_fb_size;
endmodule