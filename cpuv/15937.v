module  ogfx_gpu_dma_addr (
    vid_ram_addr_nxt_o,                       
    mclk,                                     
    puc_rst,                                  
    display_width_i,                          
    gfx_mode_1_bpp_i,                         
    gfx_mode_2_bpp_i,                         
    gfx_mode_4_bpp_i,                         
    gfx_mode_8_bpp_i,                         
    gfx_mode_16_bpp_i,                        
    vid_ram_addr_i,                           
    vid_ram_addr_init_i,                      
    vid_ram_addr_step_i,                      
    vid_ram_width_i,                          
    vid_ram_win_x_swap_i,                     
    vid_ram_win_y_swap_i,                     
    vid_ram_win_cl_swap_i                     
);
output   [`APIX_MSB:0] vid_ram_addr_nxt_o;    
input                  mclk;                  
input                  puc_rst;               
input    [`LPIX_MSB:0] display_width_i;       
input                  gfx_mode_1_bpp_i;      
input                  gfx_mode_2_bpp_i;      
input                  gfx_mode_4_bpp_i;      
input                  gfx_mode_8_bpp_i;      
input                  gfx_mode_16_bpp_i;     
input    [`APIX_MSB:0] vid_ram_addr_i;        
input                  vid_ram_addr_init_i;   
input                  vid_ram_addr_step_i;   
input    [`LPIX_MSB:0] vid_ram_width_i;       
input                  vid_ram_win_x_swap_i;  
input                  vid_ram_win_y_swap_i;  
input                  vid_ram_win_cl_swap_i; 
reg    [`APIX_MSB:0] vid_ram_line_addr;       
reg    [`LPIX_MSB:0] vid_ram_column_count;    
wire                 vid_ram_line_done    = vid_ram_addr_step_i & (vid_ram_column_count==(vid_ram_width_i-{{`LPIX_MSB{1'b0}}, 1'b1}));
wire   [`LPIX_MSB:0] vid_ram_length_mux   = vid_ram_addr_init_i ? vid_ram_width_i : display_width_i ;
wire [`LPIX_MSB+4:0] vid_ram_length_align =  {`LPIX_MSB+5{gfx_mode_1_bpp_i }} & {4'b0000, vid_ram_length_mux[`LPIX_MSB:0]         } |
                                             {`LPIX_MSB+5{gfx_mode_2_bpp_i }} & {3'b000,  vid_ram_length_mux[`LPIX_MSB:0], 1'b0   } |
                                             {`LPIX_MSB+5{gfx_mode_4_bpp_i }} & {2'b00,   vid_ram_length_mux[`LPIX_MSB:0], 2'b00  } |
                                             {`LPIX_MSB+5{gfx_mode_8_bpp_i }} & {1'b0,    vid_ram_length_mux[`LPIX_MSB:0], 3'b000 } |
                                             {`LPIX_MSB+5{gfx_mode_16_bpp_i}} & {         vid_ram_length_mux[`LPIX_MSB:0], 4'b0000} ;
wire   [`APIX_MSB:0] plus_one_val         =  {`APIX_MSB+1{gfx_mode_1_bpp_i }} & {4'b0000, {{`VRAM_MSB{1'b0}}, 1'b1}               } |
                                             {`APIX_MSB+1{gfx_mode_2_bpp_i }} & {3'b000,  {{`VRAM_MSB{1'b0}}, 1'b1},       1'b0   } |
                                             {`APIX_MSB+1{gfx_mode_4_bpp_i }} & {2'b00,   {{`VRAM_MSB{1'b0}}, 1'b1},       2'b00  } |
                                             {`APIX_MSB+1{gfx_mode_8_bpp_i }} & {1'b0,    {{`VRAM_MSB{1'b0}}, 1'b1},       3'b000 } |
                                             {`APIX_MSB+1{gfx_mode_16_bpp_i}} & {         {{`VRAM_MSB{1'b0}}, 1'b1},       4'b0000} ;
wire [`APIX_MSB*3:0] vid_ram_length_norm  =  {{`APIX_MSB*3-`LPIX_MSB-4{1'b0}}, vid_ram_length_align};
wire   [`APIX_MSB:0] next_base_addr       =  (vid_ram_addr_init_i | ~vid_ram_line_done) ? vid_ram_addr_i    :
                                                                                          vid_ram_line_addr ;
wire   [`APIX_MSB:0] next_addr            =   next_base_addr
                                            + (vid_ram_length_norm[`APIX_MSB:0] & {`APIX_MSB+1{~vid_ram_addr_init_i ? (~vid_ram_win_y_swap_i &  (vid_ram_win_cl_swap_i ^ vid_ram_line_done)) : 1'b0}})
                                            - (vid_ram_length_norm[`APIX_MSB:0] & {`APIX_MSB+1{~vid_ram_addr_init_i ? ( vid_ram_win_y_swap_i &  (vid_ram_win_cl_swap_i ^ vid_ram_line_done)) : 1'b0}})
                                            + (plus_one_val                     & {`APIX_MSB+1{~vid_ram_addr_init_i ? (~vid_ram_win_x_swap_i & ~(vid_ram_win_cl_swap_i ^ vid_ram_line_done)) : 1'b0}})
                                            - (plus_one_val                     & {`APIX_MSB+1{~vid_ram_addr_init_i ? ( vid_ram_win_x_swap_i & ~(vid_ram_win_cl_swap_i ^ vid_ram_line_done)) : 1'b0}});
wire                 update_line_addr     =   vid_ram_addr_init_i | vid_ram_line_done;
wire                 update_pixel_addr    =   update_line_addr    | vid_ram_addr_step_i;
always @(posedge mclk or posedge puc_rst)
  if (puc_rst)               vid_ram_line_addr  <=  {`APIX_MSB+1{1'b0}}; 
  else if (update_line_addr) vid_ram_line_addr  <=  next_addr; 
assign vid_ram_addr_nxt_o = update_pixel_addr ? next_addr : vid_ram_addr_i; 
always @(posedge mclk or posedge puc_rst)
  if (puc_rst)                   vid_ram_column_count  <=  {`LPIX_MSB+1{1'b0}}; 
  else if (vid_ram_addr_init_i)  vid_ram_column_count  <=  {`LPIX_MSB+1{1'b0}}; 
  else if (vid_ram_line_done)    vid_ram_column_count  <=  {`LPIX_MSB+1{1'b0}}; 
  else if (vid_ram_addr_step_i)  vid_ram_column_count  <=  vid_ram_column_count + {{`LPIX_MSB{1'b0}}, 1'b1}; 
endmodule