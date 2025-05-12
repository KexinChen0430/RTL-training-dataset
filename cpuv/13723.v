module. 
wire p0_act_cursor    = display_cursor & p0_apply_cursor;
wire p0_act_high_d    = display_cursor & p0_highlight &  direct_mode;
wire p0_act_high_id   = display_cursor & p0_highlight & !direct_mode;
wire p0_act_transl_d  = display_cursor & p0_translucent &  direct_mode;
wire p0_act_transl_id = display_cursor & p0_translucent & !direct_mode;
assign     pass_address = {8{!direct_mode}};
always @(posedge pixclk or negedge reset) begin
  if (!reset) begin 
    rgb4_0    <= 24'b0; 
    rgb4_1    <= 24'b0; 
    rgb4_2    <= 24'b0; 
    rgb4_3    <= 24'b0; 
    pix_mask1 <= 8'b0;  
    pix_mask2 <= 8'b0;  
  end else begin 
    pix_mask1 <= pix_mask; 
    pix_mask2 <= pix_mask1; 
    rgb4_0 <= pixel_stage3; 
    rgb4_1 <= rgb4_0; 
    rgb4_2 <= rgb4_1; 
    rgb4_3 <= rgb4_2; 
  end
end
assign p0_blu_pal_adr = pixel_stage3[7:0]   & pix_mask2[7:0] & pass_address;
assign p0_grn_pal_adr = pixel_stage3[15:8]  & pix_mask2[7:0] & pass_address;
assign p0_red_pal_adr = pixel_stage3[23:16] & pix_mask2[7:0] & pass_address;
wire 	 drmode =  direct_mode & !blankr;
wire 	 dbmode =  direct_mode & !blankb;
wire 	 dgmode =  direct_mode & !blankg;
always @(posedge pixclk) begin
  p0_sel_red <= {blankr, p0_act_cursor, p0_act_high_d, p0_act_high_id,
		   p0_act_transl_id, p0_act_transl_d, drmode};
  p0_sel_blu <= {blankb, p0_act_cursor, p0_act_high_d, p0_act_high_id,
		   p0_act_transl_id, p0_act_transl_d, dbmode};
  p0_sel_grn <= {blankg, p0_act_cursor, p0_act_high_d, p0_act_high_id,
		   p0_act_transl_id, p0_act_transl_d, dgmode};
  p0_red_pal_d <= p0_red_pal;
  p0_blu_pal_d <= p0_blu_pal;
  p0_grn_pal_d <= p0_grn_pal;
  p0_red_cursor_d <= p0_red_cursor;
  p0_blu_cursor_d <= p0_blu_cursor;
  p0_grn_cursor_d <= p0_grn_cursor;
end
always @(posedge pixclk or negedge reset) begin
  if (!reset) begin 
    p0_red   <= 8'b0; 
    p0_green <= 8'b0; 
    p0_blue  <= 8'b0; 
  end else begin 
    casex (p0_sel_red)
      7'b1xxxxxx  : p0_red <= 8'b0;
      7'b01xxxxx  : p0_red <= p0_red_cursor_d;
      7'b001xxxx  : p0_red <= ~rgb4_3[23:16];
      7'b0001xxx  : p0_red <= ~p0_red_pal_d;
      7'b00001xx  : p0_red <= {p0_red_cursor_d[7], p0_red_pal_d[7:1]};
      7'b000001x  : p0_red <= {p0_red_cursor_d[7], rgb4_3[23:17]};
      7'b0000001  : p0_red <= rgb4_3[23:16];
      default :     p0_red <= p0_red_pal_d;
    endcase
    casex (p0_sel_grn)
      7'b1xxxxxx  : p0_green <= 8'b0;
      7'b01xxxxx  : p0_green <= p0_grn_cursor_d;
      7'b001xxxx  : p0_green <= ~rgb4_3[15:8];
      7'b0001xxx  : p0_green <= ~p0_grn_pal_d;
      7'b00001xx  : p0_green <= {p0_grn_cursor_d[7], p0_grn_pal_d[7:1]};
      7'b000001x  : p0_green <= {p0_grn_cursor_d[7], rgb4_3[15:9]};
      7'b0000001  : p0_green <= rgb4_3[15:8];
      default :     p0_green <= p0_grn_pal_d;
    endcase
    casex(p0_sel_blu)
      7'b1xxxxxx  : p0_blue <= 8'b0;
      7'b01xxxxx  : p0_blue <= p0_blu_cursor_d;
      7'b001xxxx  : p0_blue <= ~rgb4_3[7:0];
      7'b0001xxx  : p0_blue <= ~p0_blu_pal_d;
      7'b00001xx  : p0_blue <= {p0_blu_cursor_d[7], p0_blu_pal_d[7:1]};
      7'b000001x  : p0_blue <= {p0_blu_cursor_d[7], rgb4_3[7:1]};
      7'b0000001  : p0_blue <= rgb4_3[7:0];
      default :     p0_blue <= p0_blu_pal_d;
    endcase
  end
end
endmodule 