module de_top_misc
  (
   input	         de_clk,           
   input	         sys_locked,       
   input 	         hb_clk,           
   input 	         hb_rstn,          
   input [1:0] 	         ps_2,             
   input 	         pc_mc_rdy,        
   input 	         busy_hb,          
   input 	         mw_de_fip,        
   input [4:0] 	         dr_style_2,       
   input 	         dx_blt_actv_2,    
   input 	         load_actvn,       
   input 	         line_actv_2,      
   input 	         wb_clip_ind,      
   input 	         clip,             
   input 	         deb,              
   input 	         cmd_trig_comb,    
   input  	         line_actv_1,      
   input  	         blt_actv_1,       
   input [23:0] 	 de_key_2,         
   input 	         cmdcpyclr,        
   input                 pc_empty,         
   input                 pal_busy,         
   output reg	         mw_fip,           
   output	         ca_busy,          
   output	         ps8_2,            
   output	         ps16_2,           
   output	         ps565_2,          
   output	         ps32_2,           
   output	         de_pad8_2,        
   output [1:0] 	 stpl_2,           
   output reg	         de_rstn,          
   output reg	         de_clint_tog,     
   output reg	         dx_clp,           
   output reg	         dx_deb,           
   output [31:0]         kcol_2,           
   output	         de_trnsp_2,       
   output reg	         de_ddint_tog,     
   output [3:0]          probe_misc        
   );
  wire		 wb_clip_rstn;      
  wire		 clip_ddd;          
  reg		 mw_fip_dd, de_busy_sync; 
  reg		 ca_busyi;          
  reg		 tmp_rstn;          
  reg		 clip_disab;        
  reg		 wb_clip;           
  reg		 clip_d, clip_dd;   
  reg		 deb_clr_hold;      
  reg		 deb_clr_q0,deb_clr_q1,deb_clr_q2; 
  reg 		 deb_last;          
  reg	         de_clint;          
  reg		 pal_clr_q0;        
  reg		 pal_clr_q1;        
  reg		 pal_clr_q2;        
  reg		 pal_clr;           
  assign 	 probe_misc = {ca_busyi, busy_hb, de_busy_sync, pc_mc_rdy};
  always @ (posedge de_clk) begin
    de_busy_sync <= busy_hb;              
    mw_fip_dd    <= mw_de_fip;            
    mw_fip       <= mw_fip_dd;            
  end
  always @ (posedge de_clk or negedge de_rstn) begin
    if(!de_rstn) ca_busyi <= 1'b0;        
    else         ca_busyi <= ~pc_empty | ((busy_hb & de_busy_sync) |
			      (~pc_mc_rdy & ca_busyi)); 
  end
  assign ca_busy = (ca_busyi | busy_hb);
  assign ps8_2   = (ps_2==2'b00);
  assign ps16_2  = (ps_2==2'b01) | (ps_2==2'b11);
  assign ps565_2 = (ps_2==2'b11);
  assign ps32_2  = (ps_2==2'b10);
  assign de_pad8_2 = dr_style_2[3] & dr_style_2[2];
  assign de_trnsp_2 = (dr_style_2[1] & ~dr_style_2[0] & ~(dx_blt_actv_2)) |
			 (dr_style_2[1] & ~dr_style_2[0] &
			  (dr_style_2[3] | dr_style_2[2]));
  assign stpl_2[1]  = dr_style_2[3] & ~line_actv_2;
  assign stpl_2[0]  = ~dr_style_2[3] & dr_style_2[2] & ~line_actv_2;
  always @ (posedge de_clk) begin
    tmp_rstn <= (sys_locked & hb_rstn);   
    de_rstn  <= tmp_rstn;                 
  end 
  always @ (posedge de_clk or negedge de_rstn) begin
    if (!de_rstn)         clip_disab <= 1'b0;
    else if (!load_actvn) clip_disab <= 1'b0;
    else if (clip_ddd)    clip_disab <= 1'b1;
  end 
  always @ (posedge de_clk or negedge de_rstn) begin
    if (!de_rstn)         wb_clip <= 1'b0;
    else if (clip_ddd)    wb_clip <= 1'b0; 
    else if (wb_clip_ind) wb_clip <= 1'b1; 
  end 
  always @ (posedge de_clk) begin
    clip_d <= ((clip & line_actv_2) | wb_clip); 
    clip_dd <= clip_d;                           
    de_clint <= (clip_ddd & ~clip_disab);        
  end 
  always @ (posedge de_clk or negedge de_rstn) begin
    if(!de_rstn) de_clint_tog <= 1'b0;
    else if(de_clint) de_clint_tog <= ~de_clint_tog;
  end 
  assign clip_ddd = clip_d & ~clip_dd;
  always @ (posedge de_clk or negedge de_rstn) begin
    if(!de_rstn) de_ddint_tog <= 1'b0;
    else if(cmdcpyclr) de_ddint_tog <= ~de_ddint_tog;
  end 
  always @ (posedge de_clk or negedge de_rstn) begin
    if (!de_rstn)         dx_clp <= 1'b0;
    else if (!load_actvn) dx_clp <= 1'b0;
    else if (de_clint)    dx_clp <= 1'b1;
  end 
  always @(posedge de_clk or negedge hb_rstn) begin
    if (!hb_rstn) begin
      deb_last     <= 1'b0;
      deb_clr_hold <= 1'b0;
    end else begin
      deb_last     <= deb;                        
      deb_clr_hold <= (deb_last & ~deb) ^ deb_clr_hold; 
    end
  end
  always @ (posedge hb_clk) begin
    pal_clr_q0 <= pal_busy;
    pal_clr_q1 <= pal_clr_q0;
    pal_clr_q2 <= pal_clr_q1;
    pal_clr    <= (pal_clr_q2 & ~pal_clr_q1); 
  end 
  always @ (posedge hb_clk) begin
    deb_clr_q0 <= deb_clr_hold;
    deb_clr_q1 <= deb_clr_q0;
    deb_clr_q2 <= deb_clr_q1;
  end 
  wire busy_and_not_noop;
  assign busy_and_not_noop = (busy_hb && (line_actv_1 || blt_actv_1));
  always @(posedge hb_clk or negedge hb_rstn) begin
    if (!hb_rstn)                                             dx_deb <= 1'b0;
    else if (cmd_trig_comb)    dx_deb <= 1'b1;                
    else if ((deb_clr_q2 ^ deb_clr_q1) && !busy_and_not_noop) dx_deb <= 1'b0; 
    else if (pal_clr) dx_deb <= 1'b0;                         
  end 
  assign kcol_2 = (ps8_2) ?
		  {de_key_2[7:0],de_key_2[7:0],de_key_2[7:0],de_key_2[7:0]} : 
		  (ps16_2) ? {de_key_2[15:0],de_key_2[15:0]} : {8'h0,de_key_2}; 
endmodule 