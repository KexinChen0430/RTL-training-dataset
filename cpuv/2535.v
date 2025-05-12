module by FSM
   assign over_on = (pix_y[9:6]==3) &&
                    (5<=pix_x[9:5]) && (pix_x[9:5]<=13);
   assign row_addr_o = pix_y[5:2];
   assign bit_addr_o = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h5: char_addr_o = 7'h47; 
         4'h6: char_addr_o = 7'h61; 
         4'h7: char_addr_o = 7'h6d; 
         4'h8: char_addr_o = 7'h65; 
         4'h9: char_addr_o = 7'h00; 
         4'ha: char_addr_o = 7'h4f; 
         4'hb: char_addr_o = 7'h76; 
         4'hc: char_addr_o = 7'h65; 
         default: char_addr_o = 7'h72; 
      endcase
   always @*
   begin
      text_rgb = 3'b110;  
      if (score_on)
         begin
            char_addr = char_addr_s;
            row_addr = row_addr_s;
            bit_addr = bit_addr_s;
            if (font_bit)
               text_rgb = 3'b001; 
         end
      else if (registration_on)
         begin
            char_addr = char_addr_r;
            row_addr = row_addr_r;
            bit_addr = bit_addr_r;
            if (font_bit)
               text_rgb = 3'b001; 
         end
      else if (logo_on)
         begin
            char_addr = char_addr_l;
            row_addr = row_addr_l;
            bit_addr = bit_addr_l;
            if (font_bit)
               text_rgb = 3'b011; 
         end
      else 
         begin
            char_addr = char_addr_o;
            row_addr = row_addr_o;
            bit_addr = bit_addr_o;
            if (font_bit)
               text_rgb = 3'b001; 
         end
   end
   assign text_on = {score_on, logo_on, registration_on, over_on};
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];
endmodule