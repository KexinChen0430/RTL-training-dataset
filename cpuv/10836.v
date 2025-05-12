module 
    if(fra_result) 
      begin
        mux_5_en = 1; 
        mux_4_en = 1; 
        fork 
        begin 
          incre_en = 1; 
          decre_en = 0; 
          incre_bit = 1; 
        end 
        begin 
          shift_right_en = 1; 
          shift_left_en = 0; 
          shift_right_bits = 1; 
        end 
        join 
      end 
      if(!res) 
        begin
          shift_right_en=0; 
          shift_left_en=0; 
          incre_en=0; 
          decre_en=0; 
        end 
  end 
endmodule 