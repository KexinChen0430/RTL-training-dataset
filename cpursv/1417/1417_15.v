
module jt12_timer  #(parameter  CW = 8, FW = 4, FREE_EN = 0)
  (input  rst,
   input  clk,
   input  cen,
   input  zero,
   input  [(0-1)+CW:0] start_value,
   input  load,
   input  clr_flag,
   output reg flag,
   output reg overflow);

  reg  load_l;
  reg  [(0-1)+CW:0] cnt,next;
  reg  [FW-1:0] free_cnt,free_next;
  reg  free_ov;

  
  always @(posedge clk or posedge rst)
      if (rst) flag <= 1'b0;
      else 
        begin
          if (clr_flag) flag <= 1'b0;
          else if (overflow && (cen && zero) && load) flag <= 1'b1;
            
        end
  
  always @(*)
      begin
        {free_ov,free_next} = 1'b1+{1'b0,free_cnt};
        {overflow,next} = (FREE_EN ? free_ov : 1'b1)+{1'b0,cnt};
      end
  
  always @(posedge clk)
      begin
        load_l <= load;
        if (load && !load_l) 
          begin
            cnt <= start_value;
          end
        else if (load && zero && cen) cnt <= overflow ? start_value : next;
          
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            free_cnt <= 0;
          end
        else if (cen && zero) 
          begin
            free_cnt <= free_cnt+1'd1;
          end
          
      end
endmodule

